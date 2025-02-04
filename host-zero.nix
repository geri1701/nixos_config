{ config, lib, modulesPath, pkgs, ... }: {
  imports = [ (modulesPath + "/installer/scan/not-detected.nix") ];
  boot.initrd.availableKernelModules =
    [ "xhci_pci" "ehci_pci" "ahci" "usbhid" "sd_mod" ];
  fileSystems."/" = {
    device = "/dev/disk/by-uuid/d98e465d-27f0-4b3d-be5a-f95bd43af805";
    fsType = "ext4";
  };
  fileSystems."/boot" =
    {
      device = "/dev/disk/by-uuid/2673-0095";
      fsType = "vfat";
    };
  networking.useDHCP = lib.mkDefault true;
  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.intel.updateMicrocode =
    lib.mkDefault config.hardware.enableRedistributableFirmware;
  # hardware.graphics.enable = lib.mkDefault true;
  hardware = {
    graphics = {
      enable = lib.mkDefault true;
      enable32Bit = true;
      extraPackages = with pkgs; [
        rocmPackages.clr.icd
        amdvlk
        libvdpau-va-gl
      ];
    };
  };
}
