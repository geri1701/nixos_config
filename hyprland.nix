{ pkgs, ... }: {
  wayland.windowManager.hyprland = {
    enable = true;
    extraConfig = ''
      monitor=,preferred,auto,1
      exec-once=dunst
      exec-once=waybar 
      exec-once=swaybg -i /home/geri/Pictures/wallpaper_logo.png
      exec-once=steam
      input {
          kb_file=
          kb_layout= us
          kb_variant= altgr-intl
          kb_model=
          kb_options= caps:escape
          kb_rules=
          follow_mouse=1
          touchpad {
              natural_scroll=no
          }
          sensitivity=0 # -1.0 - 1.0, 0 means no modification.
      }
      general {
          gaps_in=6
          gaps_out=15
          border_size=0
          col.active_border= 0x44FF7F00
          col.inactive_border=0x66333333
          apply_sens_to_raw=0 
      }
      decoration {
          rounding=15
          blur=1
          blur_size=3 # minimum 1
          blur_passes=1 # minimum 1
          blur_new_optimizations=1
      }
      bezier = myBezier, 0.05, 0.9, 0.1, 1.05
      # animations {
      #     enabled=1
      #     #animation=windows,1,2,default
      #     animation=border,1,3,default
      #     animation=fade,1,3,default
      #     animation=workspaces,1,6,default
      #     animation=windows,1,8,myBezier, popin 80%
      # }
        animations {
            enabled=1
            bezier = overshot, 0.13, 0.99, 0.29, 1.1
            animation = windows, 1, 4, overshot, slide
            animation = windowsOut, 1, 5, default, popin 80%
            animation = border, 1, 5, default
            animation = fade, 1, 8, default
            animation = workspaces, 1, 6, overshot, slidevert
      }
      dwindle {
          pseudotile=0 # enable pseudotiling on dwindle
      }
      gestures {
          workspace_swipe=no
      }
      windowrule=float,^(xdg-desktop-portal-gnome)$
      windowrule=float,^(Rofi)$
      windowrule=float,^(jetbrains-studio)$
      bindm=SUPER,mouse:272,movewindow
      bindm=SUPER,mouse:273,resizewindow
      bind=SUPER,Q,exec,wezterm
      bind=SUPER,RETURN,exec,wezterm
      bind=SUPER,C,killactive,
      bind=SUPER,M,exec,~/.config/rofi/bin/leave.sh
      bind=SUPER,P,exec,sirula
      bind=ALT,P,exec,~/.config/hypr/bin/clip-color.sh
      bind=SUPER,E,exec,pcmanfm
      bind=SUPER,F,togglefloating,
      bind=ALT,SPACE,exec,~/.config/rofi/bin/app-launcher.sh
      bind=SUPER,V,pseudo
      bind=SUPER,h,movefocus,l
      bind=SUPER,l,movefocus,r
      bind=SUPER,k,movefocus,u
      bind=SUPER,j,movefocus,d
      bind=SUPER,1,workspace,1
      bind=SUPER,2,workspace,2
      bind=SUPER,3,workspace,3
      bind=SUPER,4,workspace,4
      bind=SUPER,5,workspace,5
      bind=SUPER,6,workspace,6
      bind=SUPER,7,workspace,7
      bind=SUPER,8,workspace,8
      bind=SUPER,9,workspace,9
      bind=SUPER,0,workspace,10
      bind=ALT,1,movetoworkspace,1
      bind=ALT,2,movetoworkspace,2
      bind=ALT,3,movetoworkspace,3
      bind=ALT,4,movetoworkspace,4
      bind=ALT,5,movetoworkspace,5
      bind=ALT,6,movetoworkspace,6
      bind=ALT,7,movetoworkspace,7
      bind=ALT,8,movetoworkspace,8
      bind=ALT,9,movetoworkspace,9
      bind=ALT,0,movetoworkspace,10
      bind=SUPER,mouse_down,workspace,e+1
      bind=SUPER,mouse_up,workspace,e-1
      bind = SUPER,Tab,cyclenext,          # change focus
      bind = SUPER,Tab,bringactivetotop,   # to top
    '';
  };
}

