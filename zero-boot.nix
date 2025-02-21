{ pkgs, ... }: {
  boot = {
    kernelPackages = pkgs.linuxPackages_cachyos;
    initrd = {
      kernelModules = [ "i2c-dev" "amdgpu" "nct6775" "lm78" ];
      services.udev.extraRules=''KERNEL=="i2c-[0-9]*", GROUP="i2c", MODE="0660"'';
      systemd.enable = true;
      verbose = false;
    };
    kernelParams = [ "quiet" ];
    tmp.cleanOnBoot = true;
    plymouth.enable = true;
    consoleLogLevel = 0;
    loader.systemd-boot = {
      enable = true;
      configurationLimit = 10;
    };
    loader.efi.canTouchEfiVariables = true;
  };
  services.kmscon.hwRender = true;
}
