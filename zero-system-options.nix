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
}
