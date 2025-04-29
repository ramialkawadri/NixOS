{ pkgs, ... }:

{
  home.username = "ramikw";
  home.homeDirectory = "/home/ramikw";

  home.file.".config/vlc" = {
    source = ./dotfiles/vlc;
    recursive = true;
    force = true;
  };

  home.file."Pictures/NixOS" = {
    source = ./imgs;
    recursive = true;
    force = true;
  };

  home.pointerCursor = {
    name = "bibata-cursors";
    package = pkgs.bibata-cursors;

    size = 22;

    gtk.enable = true;

    x11 = {
      enable = true;
      defaultCursor = "Bibata-Modern-Classic";
    };
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
    bash-language-server
    bibtex-tidy
    clang-tools
    csharp-ls
    dockerfile-language-server-nodejs
    emmet-ls
    eslint
    gdb
    hyprls
    jdt-language-server
    ltex-ls
    lua-language-server
    netcoredbg
    nil
    python312Packages.debugpy
    python312Packages.python-lsp-server
    rust-analyzer
    texlab
    tree-sitter
    typescript-language-server
    vim-language-server
    vimPlugins.nvim-treesitter.withAllGrammars
    vscode-langservers-extracted

    # Hyprland
    avizo
    clipse
    hyprpolkitagent
    nwg-look
    pavucontrol
    playerctl
    swaylock
    sway-audio-idle-inhibit
    hyprpaper
  ];

  # Start dark theme
  dconf.settings = {
    "org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";
    };
  };

  gtk = {
    enable = true;
    theme = {
      name = "Adwaita-dark";
      package = pkgs.gnome-themes-extra;
    };
  };

  qt = {
    enable = true;
    platformTheme.name = "adwaita";
    style.name = "adwaita-dark";
  };
  # End dark theme

  programs.tmux.enable = true;

  programs.kitty = {
    enable = true;
    themeFile = "Hybrid";
    settings = {
      font_family = "HackNerdFont";
      font_size = 12;
    };
  };

  # TODO: move to own file
  services.hyprpaper = {
    enable = true;
    settings = {
      preload = [ "~/Pictures/NixOS/background.jpg" ];
      wallpaper = [ ",~/Pictures/NixOS/background.jpg" ];
    };
  };

  services.dunst = {
    enable = true;
    settings = {
        global = {
            font = "HackNerdFont 12";
            foreground = "#eee";
            frame_color = "#58a4e9";
            separator_color= "frame";
            background = "#000";
            monitor = 0;
            follow = "mouse";
            width = 320;
            height = 320;
            origin = "top-right";
            offset = "15x15";
            scale = 0;
            notification_limit = 0;
            progress_bar = false;
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
            markup = "yes";
            plain_text = "no";
            format = "<b>%s</b>\n%b";
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
            ignore_dbusclose = false;
            force_xinerama = false;
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
            format = "{:%Y/%m/%d - %H:%M}";

            calendar = {
              mode = "year";
              mode-mon-col = 3;
              weeks-pos = "right";
              on-scroll = 1;
              format = {
                months = "<span color='#ffead3'><b>{}</b></span>";
                days = "<span color='#ecc6d9'><b>{}</b></span>";
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
            on-click = "sleep 0.1 && ~/.config/rofi/powermenu/powermenu.sh";
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
