{ ... }:
{
  wayland.windowManager.hyprland = {
    enable = true;
    package = null;
    portalPackage = null;
    systemd.variables = [ "--all" ];
  };

  wayland.windowManager.hyprland.settings = {

    env = [
      "XCURSOR_SIZE,24"
      "HYPRCURSOR_SIZE,24"
      "HYPRCURSOR_THEME,Adwaita"

      # Nvidia
      "LIBVA_DRIVER_NAME,nvidia"
      "__GLX_VENDOR_LIBRARY_NAME,nvidia"
      "ELECTRON_OZONE_PLATFORM_HINT,auto"
    ];

    monitor = [
      ", highres, auto, 1.33333, bitdepth, 10"
    ];

    #################
    ### AUTOSTART ###
    #################

    exec-once = [
      "waybar & hyprpaper & dunst & hypridle"
      "systemctl --user start hyprpolkitagent"
      # Adding some sleep time to way for waybar to start
      "sleep 5 && 1password --silent"
      "sleep 5 && megasync"
      "avizo-service"
      ''hyprctl setcursor "Adwaita" 24''

      "[workspace 1 silent] firefox"
      "[workspace 4 silent] sleep 6; anki"
      "[workspace 4 silent] gnome-clocks"
    ];

    #####################
    ### LOOK AND FEEL ###
    #####################

    general = {
      gaps_in = 2;
      gaps_out = 2;

      border_size = 3;
      resize_on_border = true;

      "col.active_border" = "rgb(58a4e9)";
      "col.inactive_border" = "rgba(595959aa)";

      allow_tearing = false;
      layout = "master";
    };

    decoration = {
      rounding = 0;
      rounding_power = 0;

      blur = {
        passes = 2;
      };

      shadow = {
        enabled = true;
        range = 4;
        render_power = 3;
        color = "rgba(1a1a1aee)";
      };
    };

    xwayland = {
      force_zero_scaling = true;
    };

    animation = [
      "global, 1, 10, default"
      "border, 1, 5.39, easeOutQuint"
      "windows, 1, 4.79, easeOutQuint"
      "windowsIn, 1, 4.1, easeOutQuint, popin 87%"
      "windowsOut, 1, 1.49, linear, popin 87%"
      "fadeIn, 1, 1.73, almostLinear"
      "fadeOut, 1, 1.46, almostLinear"
      "fade, 1, 3.03, quick"
      "layers, 1, 3.81, easeOutQuint"
      "layersIn, 1, 4, easeOutQuint, fade"
      "layersOut, 1, 1.5, linear, fade"
      "fadeLayersIn, 1, 1.79, almostLinear"
      "fadeLayersOut, 1, 1.39, almostLinear"
      "workspaces, 1, 1.94, almostLinear, fade"
      "workspacesIn, 1, 1.21, almostLinear, fade"
      "workspacesOut, 1, 1.94, almostLinear, fade"
    ];

    bezier = [
      "easeOutQuint,0.23,1,0.32,1"
      "easeInOutCubic,0.65,0.05,0.36,1"
      "linear,0,0,1,1"
      "almostLinear,0.5,0.5,0.75,1.0"
      "quick,0.15,0,0.1,1"
    ];

    misc = {
      disable_hyprland_logo = true;
      focus_on_activate = true;
      vrr = 1;
      font_family = "HackNerdFont";
      middle_click_paste = false;
    };

    #############
    ### INPUT ###
    #############

    input = {
      follow_mouse = 2;
      float_switch_override_focus = 0;
      kb_layout = "no,sy";
      kb_options = "grp:alt_shift_toggle";
    };

    gestures = {
      workspace_swipe = true;
    };

    ##############################
    ### WINDOWS AND WORKSPACES ###
    ##############################

    workspace = [
      # "Smart gaps" / "No gaps when only"
      "w[tv1], gapsout:0, gapsin:0"
      "f[1], gapsout:0, gapsin:0"

      # Workspaces
      "1, persistent:true"
      "2, persistent:true"
      "3, persistent:true"
      "4, persistent:true"
      "5, persistent:true"
      "6, persistent:true"
    ];

    windowrule = [
      # "Smart gaps" / "No gaps when only"
      "bordersize 0, floating:0, onworkspace:w[tv1]"
      "rounding 0, floating:0, onworkspace:w[tv1]"
      "bordersize 0, floating:0, onworkspace:f[1]"
      "rounding 0, floating:0, onworkspace:f[1]"

      # Clipse
      "float, class:(clipse)"
      "size 622 652, class:(clipse)"
      "stayfocused, class:(clipse)"
      "opacity 0.90 override, class:^(clipse)$"

      # MEGAsync
      "float, title:(MEGAsync)"
      "bordersize 0, title:(MEGAsync)"
      "noblur, title:(MEGAsync)"

      # Ignore maximize requests from apps. You'll probably like this.
      "suppressevent maximize, class:.*"

      # Fix some dragging issues with XWayland
      "nofocus,class:^$,title:^$,xwayland:1,floating:1,fullscreen:0,pinned:0"

      # Screensharing
      "opacity 0.0 override, class:^(xwaylandvideobridge)$"
      "noanim, class:^(xwaylandvideobridge)$"
      "noinitialfocus, class:^(xwaylandvideobridge)$"
      "maxsize 1 1, class:^(xwaylandvideobridge)$"
      "noblur, class:^(xwaylandvideobridge)$"
      "nofocus, class:^(xwaylandvideobridge)$"
    ];

    ###################
    ### KEYBINDINGS ###
    ###################

    "$mainMod" = "SUPER";

    bind = [
      # General bindings
      "$mainMod, Q, exec, kitty"
      "$mainMod, B, exec, firefox"
      "$mainMod, C, killactive,"
      "$mainMod, M, exit,"
      "$mainMod, E, exec, nautilus"
      "$mainMod, L, exec, hyprlock"
      "$mainMod, F, togglefloating,"
      "$mainMod, SPACE, exec, rofi -show drun"
      "ALT, F4, exec, rofi -show power-menu --no-text -modi power-menu:${../dotfiles/rofi/rofi-power-menu}"
      "$mainMod, code:60, exec, rofi -modi emoji -show emoji -emoji-mode insert_no_copy -emoji-format '{emoji}' -theme-str \"listview { columns: 5; }\"" 
      '', Print, exec, grim -g "$(slurp -d)" - | wl-copy''
      "SUPER, V, exec, kitty --class clipse -e clipse"

      # Move focus with mainMod + arrow keys
      "$mainMod, left, movefocus, l"
      "$mainMod, right, movefocus, r"
      "$mainMod, up, movefocus, u"
      "$mainMod, down, movefocus, d"

      # Switch workspaces with mainMod + [0-9]
      "$mainMod, 1, workspace, 1"
      "$mainMod, 2, workspace, 2"
      "$mainMod, 3, workspace, 3"
      "$mainMod, 4, workspace, 4"
      "$mainMod, 5, workspace, 5"
      "$mainMod, 6, workspace, 6"
      "$mainMod, 7, workspace, 7"
      "$mainMod, 8, workspace, 8"
      "$mainMod, 9, workspace, 9"
      "$mainMod, 0, workspace, 10"

      # Move active window to a workspace with mainMod + SHIFT + [0-9]
      "$mainMod SHIFT, 1, movetoworkspace, 1"
      "$mainMod SHIFT, 2, movetoworkspace, 2"
      "$mainMod SHIFT, 3, movetoworkspace, 3"
      "$mainMod SHIFT, 4, movetoworkspace, 4"
      "$mainMod SHIFT, 5, movetoworkspace, 5"
      "$mainMod SHIFT, 6, movetoworkspace, 6"
      "$mainMod SHIFT, 7, movetoworkspace, 7"
      "$mainMod SHIFT, 8, movetoworkspace, 8"
      "$mainMod SHIFT, 9, movetoworkspace, 9"
      "$mainMod SHIFT, 0, movetoworkspace, 10"

      # Swapping within the master layout"
      "$mainMod CTRL, right, layoutmsg, swapnext"
      "$mainMod CTRL, left, layoutmsg, swapprev"

      # Scroll through existing workspaces with mainMod + scroll"
      "$mainMod, mouse_down, workspace, e+1"
      "$mainMod, mouse_up, workspace, e-1"

      # Alt + tab"
      "ALT, TAB, cyclenext,"
      "ALT, TAB, bringactivetotop,"

      # Laptop multimedia keys for volume and LCD brightness
      ",XF86AudioRaiseVolume, exec, volumectl -u up"
      ",XF86AudioLowerVolume, exec,  volumectl -u down"
      ",XF86AudioMute, exec, volumectl toggle-mute"
      ",XF86AudioMicMute, exec, volumectl -m toggle-mute"
    ];

    bindm = [
      # Move/resize windows with mainMod + LMB/RMB and dragging
      "$mainMod, mouse:272, movewindow"
      "$mainMod, mouse:273, resizewindow"
    ];

    binde = [
      # Resize bindings
      "$mainMod ALT, right, resizeactive, 20 0"
      "$mainMod ALT, left, resizeactive, -20 0"
      "$mainMod ALT, up, resizeactive, 0 -20"
      "$mainMod ALT, down, resizeactive, 0 20"
    ];

    bindel = [
      # Laptop multimedia keys for volume and LCD brightness
      ",XF86MonBrightnessUp, exec, brightnessctl s 10%+"
      ",XF86MonBrightnessDown, exec, brightnessctl s 10%-"
    ];

    bindl = [
      # Requires playerctl
      ", XF86AudioNext, exec, playerctl next"
      ", XF86AudioPause, exec, playerctl play-pause"
      ", XF86AudioPlay, exec, playerctl play-pause"
      ", XF86AudioPrev, exec, playerctl previous"
    ];
  };
}
