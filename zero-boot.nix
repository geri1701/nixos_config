{ pkgs, ... }: {
  boot = {
    kernelPackages = pkgs.linuxPackages_xanmod_stable;
    initrd = {
      kernelModules = [ "amdgpu" ];
      systemd.enable = true;
      verbose = false;
    };
    kernelParams = [ "quiet" ];
    tmp.cleanOnBoot = true;
    plymouth.enable = true;
    consoleLogLevel = 0;
    loader = {
      efi.canTouchEfiVariables = true;
      timeout = 1;
      grub = {
        enable = true;
        device = "/dev/sda";
        useOSProber = true;
        extraConfig = ''
          set timeout_style=hidden
        '';
      };
    };
  };
  services.kmscon.hwRender = true;
}
