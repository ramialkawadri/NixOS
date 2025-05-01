{ ... }:
{
  programs.waybar = {
      enable = true;
      settings = {
        mainBar = {
          layer = "top";
          height = 40;
          modules-left = ["hyprland/workspaces"];
          modules-center = ["hyprland/window"];
          modules-right = [
            "custom/media"
            "network"
            "pulseaudio"
            "tray"
            "clock"
            "custom/shutdown"
          ];

          network = {
            format = "{ifname}";
            format-wifi = "{essid} ({signalStrength}%) ";
            format-ethernet = "󰛳";
            format-disconnected = "󰅛";
            tooltip-format = "{ifname} via {gwaddr} ";
            tooltip-format-wifi = "{essid} ({signalStrength}%) ";
            tooltip-format-ethernet = "{ifname} ";
            tooltip-format-disconnected = "Disconnected";
            max-length = 50;
          };

          "hyprland/workspaces" = {
            on-click = "activate";
            on-scroll-up = "hyprctl dispatch workspace e-1";
            on-scroll-down = "hyprctl dispatch workspace e+1";
          };

          tray.spacing = 12;

          clock = {
            tooltip-format = "<tt><small>{calendar}</small></tt>";
            format = "   {:%H:%M\n%Y/%m/%d}";

            calendar = {
              mode = "year";
              mode-mon-col = 3;
              weeks-pos = "right";
              on-scroll = 1;
              format = {
                months = "<span color='#fff'><b>{}</b></span>";
                days = "<span color='#fff'><b>{}</b></span>";
                weeks = "<span color='#99ffdd'><b>W{}</b></span>";
                weekdays = "<span color='#ffcc66'><b>{}</b></span>";
                today = "<span color='#ff6699'><b><u>{}</u></b></span>";
              };
            };
          };

          pulseaudio = {
            format = "{volume}% {icon} ";
            format-bluetooth = "{volume}% {icon} {format_source}";
            format-bluetooth-muted = " {icon} {format_source}";
            format-muted = " {format_source}";
            format-source = "{volume}% ";
            format-source-muted = "";
            format-icons = {
              headphone = "";
              hands-free = "";
              headset = "";
              phone = "";
              portable = "";
              car = "";
              default = ["" "" ""];
            };
            on-click = "pavucontrol";
          };

          "custom/media" = {
            format = "{icon}  {}";
            escape = true;
            return-type = "json";
            max-length = 10;
            on-click = "playerctl play-pause";
            smooth-scrolling-threshold = 10;
            on-scroll-up = "playerctl next";
            on-scroll-down = "playerctl previous";
            exec = "$HOME/.config/waybar/mediaplayer.py 2> /dev/null";
          };

          "custom/shutdown" = {
            format = "";
            on-click = ''rofi -show power-menu --no-text -modi "power-menu:rofi-power-menu --choices=logout/suspend/hibernate/shutdown/reboot"'';
            tooltip = false;
          };
        };
      };
      # Copied from: https://github.com/mechakotik/dots/tree/main/.config/waybar
      style = ''
@define-color foreground #eeeeee;
@define-color foreground-inactive #aaaaaa;
@define-color background #000000;

* {
    font-family: HackNerdFont;
    font-size: 14px;
    padding: 0;
    margin: 0;
}

#waybar {
    color: @foreground;
    background-color: @background;
    padding: 0 4px;
}

#workspaces button {
    color: @foreground;
    padding: 0.35em;
    border: 2px solid transparent;
    color: @foreground-inactive;
}

#workspaces button.active {
    border-bottom-color: @foreground;
    color: @foreground;
}

#memory,
#temperature {
    padding-left: 1em
}

#clock,
#battery,
#cpu,
#memory,
#disk,
#temperature,
#backlight,
#network,
#pulseaudio,
#wireplumber,
#custom-media,
#tray,
#mode,
#idle_inhibitor,
#scratchpad,
#window,
#custom-shutdown,
#mpd {
    border-radius: 6px;
    padding: 0 6px;
    margin: 0 4px;
    color: #fff;
}
      '';
  };
}
