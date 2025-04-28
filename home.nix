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
