{ pkgs, ... }: {
  boot = {
    kernelPackages = pkgs.linuxPackages_latest;
    initrd = {
      kernelModules = [ "amdgpu" ];
      systemd.enable = true;
      verbose = false;
    };
    kernelParams = [
      "quiet"
      "tuxedo_keyboard.mode=0"
      "tuxedo_keyboard.brightness=100"
      "tuxedo_keyboard.color_left=0xff0a0a"
    ];
    cleanTmpDir = true;
    plymouth.enable = true;
    consoleLogLevel = 0;
    loader = {
      sytemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
  };
}
