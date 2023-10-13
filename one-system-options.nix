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
  #tuxedo control center dependency
  nixpkgs.config.permittedInsecurePackages = [
    "nodejs-14.21.3"
    "openssl-1.1.1t"
    "electron-13.6.9"
  ];
  hardware.brillo.enable = true;
  # hardware.tuxedo-keyboard.enable = true;
  # hardware.tuxedo-control-center.enable = true;
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
