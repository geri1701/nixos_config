{ pkgs, ... }:
{
  fileSystems = {
    "/" = {
      device = "/dev/disk/by-uuid/585ba183-6c2b-476f-bf32-2ff6e7017bb6";
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
  };
}
