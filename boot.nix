{ pkgs, ... }: {
  boot = {
    kernelPackages = pkgs.linuxPackages_latest;
    initrd = {
      kernelModules = [ "amdgpu" ];
      systemd.enable = true;
      verbose = false;
    };
    kernelParams = [ "quiet" "splash" ];
    cleanTmpDir = true;
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
}
