{ config, lib, modulesPath, pkgs, ... }:
{
  imports = [ (modulesPath + "/installer/scan/not-detected.nix") ];
    boot = {
    kernelPackages = pkgs.linuxPackages_cachyos; 
    initrd = {
      availableKernelModules = [ "nvme" "xhci_pci" "ehci_pci" "ahci" "usbhid" "sd_mod" ];
      kernelModules = [ "i2c-dev" "amdgpu" "nct6775" "lm78" "kvm-amd" ];
      systemd.enable = true;
      verbose = false;
    };
    kernelParams = [ "quiet" ];
    tmp.cleanOnBoot = true;
    plymouth.enable = true;
    consoleLogLevel = 0;
    loader = {
      efi.canTouchEfiVariables = true;
      systemd-boot = {
        enable = true;
        configurationLimit = 10;
        consoleMode = "max";
      };
    };
  };

   fileSystems."/" = {
    device = "none";
    fsType = "tmpfs";
    options = [ "defaults" "size=25%" "mode=755" ];
  };
  fileSystems."/persistent" = {
    neededForBoot = true;
    device = "/dev/nvme0n1p2";
    fsType = "ext4";
    options = [ "rw" "noatime" "data=ordered" "errors=remount-ro" ];
  };
  fileSystems."/home/geri/.local/share/Steam/config/htmlcache" = {
    depends = [
      "/"
      "/persistent"
    ];
    device = "none";
    fsType = "tmpfs";
    options = [ "uid=geri" "gid=users" "defaults" "size=5%" "mode=777" ];
  };
   fileSystems."/boot" =
     {
       device = "/dev/nvme0n1p1";
       fsType = "vfat";
     };
  networking.useNetworkd = lib.mkDefault true;
  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware = {
    cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;  
    amdgpu = {
       initrd.enable = true;
       amdvlk.enable = true;
       amdvlk.support32Bit.enable = true;
    };
    graphics = {
      enable = lib.mkDefault true;
      enable32Bit = true;
      extraPackages = with pkgs; [
        # rocmPackages.clr.icd
        amdvlk
        libvdpau-va-gl
        vulkan-loader
        vulkan-validation-layers
        vulkan-extension-layer
      ];
    };
    graphics.extraPackages32 = with pkgs; [
      driversi686Linux.amdvlk
  ];
 };
  networking = {
    hostName = "zero";
    wireless.enable = false;
    networkmanager = {
      enable = false;
    };
  };
  services = {
    kmscon.hwRender = true;
    # scx.enable = true;
    # scx.scheduler = "scx_bpfland";
    openssh = {
      enable = false;
      settings = { PasswordAuthentication = false; };
    };
  };
  chaotic = {
    mesa-git.enable = false;
  };
}

