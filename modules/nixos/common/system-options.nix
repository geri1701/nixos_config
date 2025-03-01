{ config, lib, pkgs, ... }:
{
  nix = {
    settings = {
      experimental-features = [ "nix-command" "flakes" ];
      auto-optimise-store = true;
      max-jobs= 4;
      cores = 16;
    };
    extraOptions = ''
      keep-outputs = true
      keep-derivations = true 
    '';
    gc = {
      automatic = true;
      dates = "daily";
      options = "--delete-older-than 7d";
    };
  };
  nixpkgs.config.allowUnfree = true;
  system.stateVersion = "24.05";
  i18n = {
    defaultLocale = "en_US.UTF-8";
    extraLocaleSettings = {
      LC_ADDRESS = "de_AT.UTF-8";
      LC_IDENTIFICATION = "de_AT.UTF-8";
      LC_MEASUREMENT = "de_AT.UTF-8";
      LC_MONETARY = "de_AT.UTF-8";
      LC_NAME = "de_AT.UTF-8";
      LC_NUMERIC = "de_AT.UTF-8";
      LC_PAPER = "de_AT.UTF-8";
      LC_TELEPHONE = "de_AT.UTF-8";
      LC_TIME = "de_AT.UTF-8";
    };
  };
   programs = {
     wireshark.enable = true;
     wireshark.package = pkgs.wireshark;
     dconf.enable = true;
     steam.enable = true;
     thunar.enable = true;
     kdeconnect.enable = true;
   };
  qt.enable = true;
    security = {
    polkit.enable = true;
    rtkit.enable = true;
  };
    services = {
    greetd = {
       enable = true;
       settings = rec {
       initial_session = {
       command = "${pkgs.hyprland}/bin/Hyprland";
       user = "geri";
     };
       default_session = initial_session;
  };
    };
    udev.packages = with pkgs; [ via ];
    udev.extraRules = ''
        KERNEL=="i2c-[0-9]*", GROUP="i2c", MODE="0660"
  '';
    pipewire = {
      enable = true;
      audio.enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      jack.enable = true;
    };
    fstrim = {
      enable = true;
      interval = "weekly";
    };
    getty = {
      loginOptions = "-p -- geri";
      extraArgs = [ "--noclear" "--skip-login" ];
    };
    gnome.gnome-keyring.enable = true;
    desktopManager.cosmic.enable = false;
    displayManager.cosmic-greeter.enable = false;
    ollama = {
     enable = true;
     acceleration = "rocm";
     environmentVariables = {
      ROCR_VISIBLE_DEVICES= "1";
      # HSA_OVERRIDE_GFX_VERSION = "10.3.0"; 
     };
    };
  }; 
  # Zeitsynchronisation ??
  services.timesyncd.enable = true;
}

