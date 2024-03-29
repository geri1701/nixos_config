# My NixOS Configuration

This repository contains the declarative, flake-based configurations for two NixOS hosts:
 - Desktop Computer `zero`
 - Tuxedo Pulse 15 Gen2 `one`

```
┌flake.nix
│
├──zero
│    ├── zero-boot.nix
│    ├── zero-system-options.nix
│    ├── system-packages.nix
│    ├── host-zero.nix
│    ├── stylix 
│    └── home-manager
│         ├── config/firefox.nix
│         ├── config/foot.nix
│         ├── config/git.nix
│         ├── config/helix.nix
│         ├── config/hyprland.nix
│         ├── config/waybar.nix
│         ├── config/zathura.nix
│         ├── config/zellij.nix
│         ├── config/zsh.nix
│         ├── home-options.nix
│         └── home-packages.nix
└──one
    ├── one-boot.nix
    ├── one-system-options.nix
    ├── system-packages.nix
    ├── host-one.nix
    ├── stylix 
    └── home-manager
         ├── config/firefox.nix
         ├── config/foot.nix
         ├── config/git.nix
         ├── config/helix.nix
         ├── config/hyprland.nix
         ├── config/waybar.nix
         ├── config/zathura.nix
         ├── config/zellij.nix
         ├── config/zsh.nix
         ├── home-options.nix
         └── home-packages.nix
```

## Resources

- Official documentation: https://nixos.org/
- NobbZ' Blog: https://blog.nobbz.dev/
- NixOS Wiki: https://nixos.wiki/
- stylix: https://github.com/danth/stylix
- hyprland: https://hyprland.org/
