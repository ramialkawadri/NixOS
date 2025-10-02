{ pkgs, ... }:

{
  imports = 
    [
      ./modules/clipse.nix
      ./modules/theme.nix
      ./modules/hypridle.nix
      ./modules/hyprland.nix
      ./modules/hyprlock.nix
      ./modules/hyprpaper.nix
      ./modules/lazygit.nix
      ./modules/rofi.nix
      ./modules/swaync.nix
      ./modules/tmux.nix
      ./modules/waybar.nix
      ./modules/zsh.nix
    ];

  home.username = "ramikw";
  home.homeDirectory = "/home/ramikw";
  xdg = {
    enable = true;
    userDirs.enable = true;
  };

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

  home.file.".vsnip" = {
    source = ./dotfiles/vsnip;
    recursive = true;
    force = true;
  };

  home.pointerCursor = {
    name = "Adwaita";
    package = pkgs.adwaita-icon-theme;

    size = 24;
    gtk.enable = true;

    x11 = {
      enable = true;
      defaultCursor = "Adwaita";
    };
  };

  programs.kitty = {
    enable = true;
    themeFile = "Hybrid";
    settings = {
      font_family = "HackNerdFont";
      font_size = 12;
      confirm_os_window_close = 0;
    };
  };

  home.packages = with pkgs; [
    tmuxinator

    hunspell
    hunspellDicts.nb_NO
    hunspellDicts.en_US
    libreoffice

    anki
    discord
    drawio
    gimp3
    megasync
    mpv
    shotcut
    thunderbird
    vlc
    vscode

    baobab  # Disk Usage Analyzer
    gnome-calculator
    gnome-characters
    gnome-clocks
    gnome-disk-utility
    gnome-font-viewer
    gnome-logs
    gnome-text-editor
    loupe
    mission-center
    nautilus
    papers
    simple-scan

    cargo
    clippy
    csharpier
    delta
    docker-compose
    dotnet-sdk_9
    gcc
    grcov
    jdk
    kubectl
    minikube
    nodejs
    postman
    python314
    rustc
    rustfmt
    sqlite
    vscode-extensions.vadimcn.vscode-lldb

    # Neovim lsps and treesitter
    bash-language-server
    bibtex-tidy
    clang-tools
    dockerfile-language-server
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
    stable.roslyn-ls
    texlab
    tree-sitter
    typescript-language-server
    vim-language-server
    vimPlugins.nvim-treesitter.withAllGrammars
    vscode-langservers-extracted

    # Hyprland
    avizo
    hypridle
    hyprpaper
    hyprpicker
    hyprpolkitagent
    nwg-look
    pavucontrol
    playerctl

    # Screenshot
    grim
    slurp
  ];

  home.sessionVariables = {
      sqlite_clib_path = "${pkgs.sqlite.out}/lib/libsqlite3${pkgs.hostPlatform.extensions.sharedLibrary}";
  };

  home.sessionPath = [
    "${pkgs.vscode-extensions.vadimcn.vscode-lldb}/share/vscode/extensions/vadimcn.vscode-lldb/adapter"
    "${pkgs.vscode-extensions.vadimcn.vscode-lldb}/share/vscode/extensions/vadimcn.vscode-lldb/lldb/bin"
  ];

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
