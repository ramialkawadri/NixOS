{ pkgs, ... }:

{
  home.username = "ramikw";
  home.homeDirectory = "/home/ramikw";

  home.file.".config/vlc" = {
    source = ./dotfiles/vlc;
    recursive = true;
    force = true;
  };

  home.file.".config/autostart" = {
    source = ./dotfiles/autostart;
    recursive = true;
    force = true;
  };

  home.packages = with pkgs; [
    tmuxinator

    anki
    discord
    drawio
    krita
    libreoffice
    megasync
    shotcut
    thunderbird
    vlc
    vscode

    kdePackages.filelight
    kdePackages.kalk
    kdePackages.kcharselect
    kdePackages.kclock
    kdePackages.kcolorchooser
    kdePackages.ksystemlog

    cargo
    clippy
    delta
    dotnet-sdk
    gcc
    jdk
    lazygit
    nodejs
    postman
    python314
    rustc
    rustfmt

    # Neovim lsps and treesitter
    tree-sitter
    vimPlugins.nvim-treesitter.withAllGrammars
    bash-language-server
    bibtex-tidy
    clang-tools
    csharp-ls
    dockerfile-language-server-nodejs
    emmet-ls
    eslint
    gdb
    jdt-language-server
    ltex-ls
    lua-language-server
    netcoredbg
    nil
    python312Packages.debugpy
    python312Packages.python-lsp-server
    rust-analyzer
    texlab
    typescript-language-server
    vim-language-server
    vscode-langservers-extracted

    # Hyprland
    nwg-look
    hyprpolkitagent
    clipse
  ];

  programs.tmux.enable = true;

  services.dunst = {
    enable = true;
    settings = {
        global = {
            font = "Hack 12";
            foreground = "#000";
            frame_color = "#1971c2";
            separator_color= "frame";
            background = "#F5F5F5";
            monitor = 0;
            follow = "mouse";
            width = 320;
            height = 320;
            origin = "top-right";
            offset = "15x15";
            scale = 0;
            notification_limit = 0;
            progress_bar = "false";
            indicate_hidden = "yes";
            transparency = 0;
            separator_height = 2;
            padding = "10";
            horizontal_padding = 10;
            text_icon_padding = 0;
            frame_width = 4;
            gap_size = 0;
            sort = "yes";
            idle_threshold = 120;
            line_height = 0;
            markup = "full";
            format = "%s %p\n%b";
            alignment = "left";
            vertical_alignment = "center";
            show_age_threshold = 60;
            ellipsize = "middle";
            ignore_newline = "no";
            stack_duplicates = "true";
            hide_duplicate_count = "false";
            show_indicators = "yes";
            icon_position = "left";
            min_icon_size = 0;
            max_icon_size = 32;
            sticky_history = "yes";
            history_length = 20;
            always_run_script = true;
            corner_radius = 6;
            ignore_dbusclose = "false";
            force_xinerama = "false";
            mouse_left_click = "close_current";
            mouse_middle_click = "do_action, close_current";
            mouse_right_click = "close_all";
        };
        urgency_critical = {
            background = "#d64e4e";
            foreground = "#f0e0e0";
            frame_color = "#d64e4e";
            timeout = 0;
        };
    };
  };

  programs.waybar = {
      enable = true;
      settings = {
        mainBar = {
          layer = "top";
          height = 41; 
          spacing = 0; 
          modules-left = ["hyprland/workspaces"];
          modules-center = ["hyprland/window"];
          modules-right = ["custom/media" "network" "pulseaudio" "tray" "clock" "custom/shutdown"];
          margin = "0";

          network = {
              format = "{ifname}";
              format-wifi = "{essid} ({signalStrength}%) ";
              format-ethernet = "󰛳 ";
              format-disconnected = "󰅛 ";
              tooltip-format = "{ifname} via {gwaddr} ";
              tooltip-format-wifi = "{essid} ({signalStrength}%) ";
              tooltip-format-ethernet = "{ifname} ";
              tooltip-format-disconnected = "Disconnected";
              max-length = 50;
          };

          "hyprland/workspaces" = {
              on-click = "activate";
              on-scroll-up = "hyprctl dispatch workspace e+1";
              on-scroll-down = "hyprctl dispatch workspace e-1";
              persistent-workspaces = {
                "1" = [];
                "2" = [];
                "3" = [];
                "4" = [];
              };
          };

          tray = {
              spacing = 12;
          };

          clock = {
              tooltip-format = "<big>{:%Y %B}</big>\n<tt><small>{calendar}</small></tt>";
              format = "{:%Y/%m/%d - %H:%M}";
          };

          pulseaudio = {
              format = "{volume}% {icon}";
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
              format = "󰜉";
              on-click = "sleep 0.1 && ~/.config/rofi/powermenu/powermenu.sh";
          };
        };
      };
      style = ''
        * {
        /* `otf-font-awesome` is required to be installed for icons */
            font-family: HackNerdFont-Regular;
            font-size: 14px;
        }

        window#waybar {
            background-color: rgba(245, 245, 245, 0.9);
            color: #000;
            transition-property: background-color;
            transition-duration: .5s;
            padding: 4px 8px;
        }

        window#waybar.hidden {
            opacity: 0.2;
        }

        window#waybar.termite {
            background-color: #3F3F3F;
        }

        window#waybar.chromium {
            background-color: #000000;
            border: none;
        }

        button {
            /* Use box-shadow instead of border so the text isn't offset */
            box-shadow: inset 0 -3px transparent;
            /* Avoid rounded borders under each button name */
            border: none;
            border-radius: 0;
        }

        #workspaces {
            padding: 4px;
        }

        #workspaces button {
            background-color: rgb(200, 200, 200);
            border-radius: 20px;
            margin-right: 8px;
        }

        #workspaces button:hover {
            background: none;
            border: none;
            background-color: rgb(180, 180, 180);
            text-shadow: inherit;
        }

        #workspaces button.active {
            background-color: #1971c2;
            color: #fff;
        }

        #workspaces button.active:hover {
            background-color: #145a9b;
        }

        #workspaces button.urgent {
            background-color: #eb4d4b;
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
            border-radius: 20px;
            padding: 0 12px;
            margin: 4px 4px;
            color: #fff;
        }

        #window {
            color: #000;
        }

        #window.empty {
            background-color: inherit;
        }

        /* If workspaces is the leftmost module, omit left margin */
        .modules-left > widget:first-child > #workspaces {
            margin-left: 0;
        }

        /* If workspaces is the rightmost module, omit right margin */
        .modules-right > widget:last-child > #workspaces {
            margin-right: 0;
        }

        #clock {
            color: #000;
            background-color: rgb(200, 200, 200);
        }

        label:focus {
            background-color: #000000;
        }

        #pulseaudio {
            background-color: #c92a2a;
        }


        #network {
            background-color: #d9480f;
            padding: 8px 12px;
        }

        #tray {
            background-color: #1971c2;
        }

        #tray > .passive {
            -gtk-icon-effect: dim;
        }

        #tray > .needs-attention {
            -gtk-icon-effect: highlight;
            background-color: #eb4d4b;
        }

        #custom-launcher {
            margin: 8px 16px;
            font-size: 18px;
            color: #1793D1;
        }

        #custom-media {
            background-color: rgb(200, 200, 200);
            color: #000;
            min-width: 120px;
        }

        #custom-shutdown {
            margin-right: 16px;
            margin-left: 0;
            color: #000;
            font-weight: 600;
            font-size: 16px;
        }
      '';
  };

  # This value determines the home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update home Manager without changing this value. See
  # the home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "24.11";

  # Let home Manager install and manage itself.
  programs.home-manager.enable = true;
}
