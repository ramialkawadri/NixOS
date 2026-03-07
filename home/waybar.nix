{ ... }:
{
  programs.waybar = {
    enable = true;
    settings = {
      mainBar = {
        layer = "bottom";
        position = "bottom";
        height = 40;
        modules-left = [ "hyprland/workspaces" ];
        modules-center = [ "hyprland/window" ];
        modules-right = [
          "keyboard-state"
          "network"
          "battery"
          "pulseaudio"
          "tray"
          "hyprland/language"
          "clock"
          "custom/notification"
        ];

        network = {
          format = "{ifname}";
          format-wifi = "{signalStrength}% ";
          format-ethernet = "󰛳";
          format-disconnected = "󰅛";
          tooltip-format = "{ifname} via {gwaddr} ";
          tooltip-format-wifi = "{essid} ({signalStrength}%) ";
          tooltip-format-ethernet = "{ifname} ";
          tooltip-format-disconnected = "Disconnected";
          max-length = 50;
        };

        battery = {
          format = "{capacity}% {icon}";
          format-charging = "{capacity}% ";
          format-plugged = "{capacity}% ";
          format-icons = [
            ""
            ""
            ""
            ""
            ""
          ];
        };

        keyboard-state = {
          capslock = true;
          format = {
            capslock = "{icon}";
          };
          format-icons = {
            locked = "󰪛";
            # Hidden
            unlocked = "";
          };
          binding-keys = [
            58
            66
            69
            70
          ];
        };

        "hyprland/workspaces" = {
          on-click = "activate";
          on-scroll-up = "hyprctl dispatch workspace e-1";
          on-scroll-down = "hyprctl dispatch workspace e+1";
        };

        "hyprland/language" = {
          format = "{shortDescription}";
        };

        tray.spacing = 12;

        clock = {
          tooltip-format = "<tt><small>{calendar}</small></tt>";
          format = "   {:%H:%M\n%Y/%m/%d}";

          calendar = {
            mode = "year";
            mode-mon-col = 3;
            weeks-pos = "left";
            on-scroll = 1;
            format = {
              months = "<span color='#333'><b>{}</b></span>";
              days = "<span color='#333'><b>{}</b></span>";
              weeks = "<span color='#2b8be3'><b>{:%V}</b></span>";
              weekdays = "<span color='#fa0'><b>{}</b></span>";
              today = "<span color='#f37'><b><u>{}</u></b></span>";
            };
          };
        };

        "custom/notification" = {
          tooltip = true;
          tooltip-format = "{} notifications";
          format = "{icon}";
          format-icons = {
            notification = "";
            none = "";
            dnd-notification = "󰂛";
            dnd-none = "󰪑";
            inhibited-notification = "";
            inhibited-none = "";
            dnd-inhibited-notification = "󰂛";
            dnd-inhibited-none = "󰪑";
          };
          return-type = "json";
          exec-if = "which swaync-client";
          exec = "swaync-client -swb";
          on-click = "swaync-client -t -sw";
          on-click-right = "swaync-client -d -sw";
          escape = true;
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
            default = [
              ""
              ""
              ""
            ];
          };
          on-click = "pavucontrol";
        };
      };
    };

    # Copied from: https://github.com/mechakotik/dots/tree/main/.config/waybar
    style = ''
      @define-color background #fafafa;
      @define-color foreground #333333;
      @define-color foreground-inactive #4d4d4d;

      * {
          font-family: HackNerdFont;
          font-size: 14px;
          padding: 0;
          margin: 0;
      }

      #waybar {
          color: @foreground;
          background-color: @background;
          padding: 0 6px;
      }

      #workspaces button {
          border-radius: 0;
          padding: 0.35em;
          border-bottom: 3px solid transparent;
          color: @foreground-inactive;
      }

      #workspaces button:hover,
      #workspaces button.active:hover {
          background: @foreground;
          color: @background;
      }

      #workspaces button.active {
          border-bottom-color: @foreground;
          color: @foreground;
      }

      tooltip {
          background: #e1e1e1;
      }

      tooltip label {
          color: @foreground;
          text-shadow: none;
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
      #network,
      #pulseaudio,
      #wireplumber,
      #tray,
      #mode,
      #idle_inhibitor,
      #scratchpad,
      #window,
      #mpd,
      #keyboard-state,
      #custom-notification,
      #language {
          padding: 3px 6px;
          margin: 0 4px;
          color: @foreground;
      }

      #keyboard-state label {
          color: transparent;
      }

      #keyboard-state label.locked {
          color: @foreground;
      }
    '';
  };
}
