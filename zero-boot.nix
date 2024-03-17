{ pkgs, ... }: {
  boot = {
    kernelPackages = pkgs.linuxPackages_cachyos;
    initrd = {
      kernelModules = [ "amdgpu" ];
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
