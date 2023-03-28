{ pkgs, ... }: {
  boot = {
    kernelPackages = pkgs.linuxPackages_latest;
    initrd = {
      kernelModules = [ "amdgpu" ];
      systemd.enable = true;
      verbose = false;
    };
    kernelParams = [ "quiet" ];
    cleanTmpDir = true;
    plymouth.enable = true;
    consoleLogLevel = 0;
    loader = {
      sytemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
  };
}
