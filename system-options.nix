{ pkgs, lib, ... }: {
  console = { useXkbConfig = true; };
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
  i18n = {
    defaultLocale = "en_US.UTF-8";
    extraLocaleSettings = {
      LC_ADDRESS = "de_AT.UTF-8";
      LC_IDENTIFICATION = "de_AT.UTF-8";
      LC_MEASUREMENT = "de_AT.UTF-8";
      LC_MONETARY = "de_AT.UTF-8";
      LC_NAME = "de_AT.UTF-8";
      LC_NUMERIC = "de_AT.UTF-8";
      LC_PAPER = "de_AT.UTF-8";
      LC_TELEPHONE = "de_AT.UTF-8";
      LC_TIME = "de_AT.UTF-8";
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
  services = {
    openssh = {
      enable = false;
      settings = { PasswordAuthentication = false; };
    };
    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      jack.enable = true;
    };
    printing.enable = true;
    fstrim = {
      enable = true;
      interval = "weekly";
    };
  };
  systemd.services = {
    mpd.environment = { XDG_RUNTIME_DIR = "/run/user/1000"; };
    sort-att-dir = {
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
  };
  time.timeZone = "Europe/Vienna";
  virtualisation = {
    docker = {
      enable = true;
      enableOnBoot = true;
    };
    libvirtd.enable = true;
  };
}
