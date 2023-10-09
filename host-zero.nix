{ config, lib, modulesPath, ... }: {
  imports = [ (modulesPath + "/installer/scan/not-detected.nix") ];
  boot.initrd.availableKernelModules =
    [ "xhci_pci" "ehci_pci" "ahci" "usbhid" "sd_mod" ];
  fileSystems."/" = {
    device = "/dev/disk/by-label/root";
    fsType = "ext4";
  };
  fileSystems."/home" = {
    device = "/dev/disk/by-label/home";
    fsType = "ext4";
  };
  fileSystems."/mnt/data" = {
    device = "/dev/disk/by-label/slow";
    fsType = "ext4";
  };
  swapDevices =
    [{ device = "/dev/disk/by-uuid/3a642c21-5c9e-40dd-afc1-0c9d3d5c67a8"; }];
  networking.useDHCP = lib.mkDefault true;
  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.intel.updateMicrocode =
    lib.mkDefault config.hardware.enableRedistributableFirmware;
    hardware.opengl.enable = lib.mkDefault true;
}
