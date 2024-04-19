{ pkgs, ... }: {
  boot = {
    # kernelPackages = pkgs.linuxPackages_latest;
    initrd = {
      systemd.enable = true;
      verbose = false;
    };
    kernelParams = [
      "quiet"
      "tuxedo_keyboard.mode=0"
      "tuxedo_keyboard.brightness=100"
      "tuxedo_keyboard.color_left=0xff0a0a"
    ];
    tmp.cleanOnBoot = true;
    plymouth.enable = true;
    consoleLogLevel = 0;
    loader = {
      systemd-boot = { 
         enable = true;
         configurationLimit = 10;
      };
      efi.canTouchEfiVariables = true;
      efi.efiSysMountPoint = "/boot";
    };
  }; 
}
