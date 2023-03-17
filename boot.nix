{ pkgs, ... }: {
  boot = {
    kernelPackages = pkgs.linuxPackages_latest;
    initrd.kernelModules = [ "amdgpu" ];
    kernelParams = [ "quiet" ];
    cleanTmpDir = true;
    plymouth.enable = true;
    initrd.systemd.enable = true;
    loader = {
      efi.canTouchEfiVariables = true;
      timeout = 1;
      grub = {
        enable = true;
        device = "/dev/sda";
        useOSProber = true;
      };
    };
  };
}
