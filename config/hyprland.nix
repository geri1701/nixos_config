{ config, ... }: {
  wayland.windowManager.hyprland = {
    enable = true;
    xwayland.enable = true;
    systemd.enable = true;
    # settings = {
    #    exec-once = [
    #       # Fixes cursor themes in gnome apps under hyprland
    #            "gsettings set org.gnome.desktop.interface cursor-theme 'rose-pine-hyprcursor'"
    #             "gsettings set org.gnome.desktop.interface cursor-size 24"
    #           ];
    #        };
     extraConfig = ''
      monitor= ${config.monitorSettingsOption}
      exec-once=dunst
      exec-once=nwg-panel
      exec-once=swaybg -i /home/geri/nixos/wallpaper.png
      exec-once=keepassxc 
      exec-once=nextcloud
      exec-once = dbus-update-activation-environment --systemd HYPRLAND_INSTANCE_SIGNATURE
      exec = hyprshade auto
      env=XDG_CURRENT_DESKTOP,Hyprland      
      input {
          kb_layout= de
          kb_variant= us
          kb_options= caps:escape
          follow_mouse=1
      }
      master {
         orientation = center
         slave_count_for_center_master = 2
         mfact = 0.5
      }
      general {
          gaps_in=3
          gaps_out=7
          border_size=2
          col.active_border= rgba(FF731Dee) 
          col.inactive_border= rgba(32603Fee)
          layout=master
      }
      misc {
         disable_hyprland_logo=true
      }
      decoration {
          rounding=8
          rounding_power=4
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
      gestures {
          workspace_swipe=no
      }
      bindm=SUPER,mouse:272,movewindow
      bindm=SUPER,mouse:273,resizewindow
      bind=SHIFT,right,resizeactive,10 0
      bind=SHIFT,left,resizeactive,-10 0
      bind=SHIFT,up,resizeactive, 0 -10
      bind=SHIFT,down,resizeactive,0 10
      bind=SUPER,RETURN,exec,ghostty
      bind=,XF86AudioLowerVolume,exec,wpctl set-volume @DEFAULT_AUDIO_SINK@ 1%-           
      bind=,XF86AudioRaiseVolume,exec,wpctl set-volume @DEFAULT_AUDIO_SINK@ 1%+           
      bind=,XF86AudioMute,exec,wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle           
      bind=,XF86MonBrightnessDown,exec,brillo -U 1
      bind=,XF86MonBrightnessUp,exec,brillo -A 1                       
      bind=SUPER,C,killactive,
      bind=SUPER,M,exec,~/.config/rofi/bin/leave.sh
      bind=SUPER,P,exec,anyrun
      bind=ALT,P,exec,~/.config/hypr/bin/clip-color.sh
      #bind=SUPER,E,exec,pcmanfm
      bind=SUPER,F,togglefloating,
      bind=ALT,SPACE,exec,pkill -f -64 nwg-panel
      bind=SUPER,V,pseudo
      bind=SUPER,h,movefocus,l
      bind=SUPER,l,movefocus,r
      bind=SUPER,k,movefocus,u
      bind=SUPER,j,movefocus,d
      bind=SUPER,H,swapwindow,l
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
      bind = SUPER+SHIFT,Tab,swapnext,          # change position
      bind = SUPER,Tab,bringactivetotop,   # to top
      bind = SUPER, t, togglegroup
      bind = SUPER+ALT, J, changegroupactive, f
      bind = SUPER+ALT, K, changegroupactive, b
      env = AQ_DRM_DEVICES,/dev/dri/card1:/dev/dri/card0
      env = HYPRCURSOR_THEME,rose-pine-hyprcursor
    '';
  };
}

