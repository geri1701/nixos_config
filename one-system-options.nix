{ pkgs, ... }:
{
  fileSystems = {
    "/" = {
      device = "/dev/disk/by-uuid/51c54e88-7be4-4df9-849d-49fec9013bbd";
      fsType = "ext4";
      options = [ "rw" "noatime" "data=ordered" "errors=remount-ro" ];
    };
    "/home" = {
      device = "/dev/disk/by-uuid/654ad835-1384-45e4-bf82-dfb582de0e92";
      fsType = "ext4";
      options = [ "rw" "noatime" "discard" "nodelalloc" "errors=remount-ro" ];
      neededForBoot = true;
    };
    "/boot" = {
      device = "/dev/disk/by-uuid/6C1C-EF49";
      fsType = "vfat";
    };
  };
  hardware = {
    brillo.enable = true;
    bluetooth.enable = true;
    tuxedo-rs.enable = true;
    tuxedo-rs.tailor-gui.enable = true;
  };
  networking = {
    hostName = "one";
    wireless.enable = false;
    networkmanager = {
      enable = true;
      insertNameservers = [ "8.8.8.8" "8.8.4.4" ];
    };
  };
  environment.systemPackages = [
    pkgs.linuxKernel.packages.linux_xanmod_latest.tuxedo-keyboard
    pkgs.tuxedo-rs
  ];
  services = {
    openssh = {
      enable = true;
      settings = {
        PasswordAuthentication = false;
        KbdInteractiveAuthentication = false;
      };
    };
    blueman.enable = true;
  };
    chaotic = {
    mesa-git.enable = true;
    scx.enable = true;
    scx.scheduler = "scx_rusty";
  };
}
