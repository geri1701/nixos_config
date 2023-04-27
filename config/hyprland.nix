{ pkgs, ... }: {
  wayland.windowManager.hyprland = {
    enable = true;
    extraConfig = ''
      monitor=,preferred,auto,auto
      exec-once=dunst
      exec-once=waybar 
      exec-once=swaybg -i /home/geri/nixos/wallpaper_logo.png
      exec-once=steam -silent
      exec-once=blueman-applet      
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
          gaps_in=3
          gaps_out=7
          border_size=2
          col.active_border= 0x44b58900 
          col.inactive_border= 0x44002b36
          apply_sens_to_raw=0 
      }
      misc {
         disable_hyprland_logo=true
      }
      decoration {
          rounding=8
          blur=1
          blur_size=3 # minimum 1
          blur_passes=1 # minimum 1
          blur_new_optimizations=1
      }
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
      bindm=SUPER,mouse:272,movewindow
      bindm=SUPER,mouse:273,resizewindow
      bind=SUPER,Q,exec,foot -L
      bind=SUPER,RETURN,exec,foot -L
      bind=,XF86AudioLowerVolume,exec,wpctl set-volume @DEFAULT_AUDIO_SINK@ 1%-           
      bind=,XF86AudioRaiseVolume,exec,wpctl set-volume @DEFAULT_AUDIO_SINK@ 1%+           
      bind=,XF86AudioMute,exec,wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle           
      bind=,XF86MonBrightnessDown,exec,brillo -U 1
      bind=,XF86MonBrightnessUp,exec,brillo -A 1            
      bind=,XF86TouchpadToggle,exec,toggle_touchpad           
      bind=SUPER,C,killactive,
      bind=SUPER,M,exec,~/.config/rofi/bin/leave.sh
      bind=SUPER,P,exec,sirula
      bind=,Menu,exec,sirula
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

