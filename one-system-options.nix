{ pkgs, ... } :
{
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
    "/boot/efi" = {
      device = "/dev/disk/by-label/EFI";
      fsType = "vfat";
    };
  };
  hardware.brillo.enable = true;
  hardware.bluetooth.enable = true;
  hardware.tuxedo-rs.enable = true;
  hardware.tuxedo-rs.tailor-gui.enable = true;
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
