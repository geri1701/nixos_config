{
  fileSystems = {
    "/" = {
      device = "/dev/disk/by-uuid/d98e465d-27f0-4b3d-be5a-f95bd43af805";
      fsType = "ext4";
      options = [ "rw" "noatime" "data=ordered" "errors=remount-ro" ];
    };
  };
  networking = {
    hostName = "zero";
    wireless.enable = false;
    networkmanager = {
      enable = true;
      # insertNameservers = [ "8.8.8.8" "8.8.4.4" ];
    };
  };
  services = {
    scx.enable = true;
    scx.scheduler = "scx_bpfland";
    openssh = {
      enable = false;
      settings = { PasswordAuthentication = false; };
    };
  };
  chaotic = {
    mesa-git.enable = true;
  };

}
