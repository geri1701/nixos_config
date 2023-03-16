{ pkgs, lib, ... }: {
  environment.sessionVariables.EDITOR = "hx";
  fileSystems = {
    "/" = {
      device = "/dev/disk/by-label/root";
      fsType = "ext4";
      options = [ "rw" "noatime" "data=ordered" "errors=remount-ro" ];
    };
    "/home" = {
      device = "/dev/disk/by-label/home";
      fsType = "ext4";
      options = [ "rw" "noatime" "discard" "nodelalloc" "errors=remount-ro" ];
      neededForBoot = true;
    };
    "/mnt/data" = {
      device = "/dev/disk/by-label/slow";
      fsType = "ext4";
      options = [ "defaults" "noatime" "nodiratime" ];
    };
  };
  networking = {
    hostName = "zero";
    wireless.enable = false;
    networkmanager = {
      enable = true;
      insertNameservers = [ "8.8.8.8" "8.8.4.4" ];
    };
  };
  programs = {
    gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
    };
    dconf.enable = true;
    steam = {
      enable = true;
      remotePlay.openFirewall =
        true; # Open ports in the firewall for Steam Remote Play
      dedicatedServer.openFirewall =
        true; # Open ports in the firewall for Source Dedicated Server
    };
  };
  systemd.services.sort-att-dir = {
    description = "sort files";
    serviceConfig = {
      Type = "oneshot";
      ExecStart = lib.mkForce (pkgs.writeShellScript "clean_att_dir" ''
        mkdir -p /home/geri/mail_att/gehalt /home/geri/mail_att/rechnung
        shopt -s nocaseglob
        for file in "/home/geri/mail_att"/*{gehalt,rechnung}*; do
            if [[ -f "$file" ]]; then
                if echo "$file" | grep -qi "gehalt"; then
                    mv "$file" "/home/geri/mail_att/gehalt" >/dev/null 2>&1
                elif echo "$file" | grep -qi "rechnung"; then
                    mv "$file" "/home/geri/mail_att/rechnung" >/dev/null 2>&1
                fi
            fi
        done
        shopt -u nocaseglob
      '');
    };
    wantedBy = [ "multi-user.target" ];
  };
  virtualisation.libvirtd.enable = true;
}
