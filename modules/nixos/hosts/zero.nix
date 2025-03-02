{ config, lib, modulesPath, pkgs, ... }: {
  imports = [ (modulesPath + "/installer/scan/not-detected.nix") ];
  boot = {
    kernelPackages = pkgs.linuxPackages_cachyos;
    initrd = {
      kernelModules = [ "i2c-dev" "amdgpu" "nct6775" "lm78" ];
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
    initrd.availableKernelModules =
      [ "xhci_pci" "ehci_pci" "ahci" "usbhid" "sd_mod" ];
  };
  fileSystems."/" = {
    device = "/dev/disk/by-uuid/d98e465d-27f0-4b3d-be5a-f95bd43af805";
    fsType = "ext4";
    options = [ "rw" "noatime" "data=ordered" "errors=remount-ro" ];
  };
  fileSystems."/boot" = {
    device = "/dev/disk/by-uuid/2673-0095";
    fsType = "vfat";
  };
  networking = {
    useDHCP = lib.mkDefault true;
    hostName = "zero";
    wireless.enable = false;
    networkmanager = { enable = true; };
  };
  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.intel.updateMicrocode =
    lib.mkDefault config.hardware.enableRedistributableFirmware;
  hardware = {
    amdgpu = {
      initrd.enable = true;
      amdvlk.enable = true;
    };
    graphics = {
      enable = lib.mkDefault true;
      enable32Bit = true;
      extraPackages = with pkgs; [ rocmPackages.clr.icd amdvlk libvdpau-va-gl ];
    };
  };
  services = {
    scx.enable = true;
    scx.scheduler = "scx_bpfland";
    openssh = {
      enable = false;
      settings = { PasswordAuthentication = false; };
    };
    kmscon.hwRender = true;
  };
  chaotic = { mesa-git.enable = true; };
  config.monitorSettingsOption = "DP-2,3440x1440@120.00Hz,0x0,1.0";
  config.firefoxPixelsPerPxOption = "0.65";
  config.outputDeviceOption = "DP-2";
}
