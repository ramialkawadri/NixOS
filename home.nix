{ pkgs, ... }:

{
  imports = 
    [
      ./modules/dark-theme.nix
      ./modules/dunst.nix
      ./modules/hypridle.nix
      ./modules/hyprlock.nix
      ./modules/hyprpaper.nix
      ./modules/rofi.nix
      ./modules/waybar.nix
    ];

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
    gimp
    libreoffice
    megasync
    shotcut
    thunderbird
    vlc
    vscode

    gnome-calculator
    gnome-characters
    gnome-clocks
    gnome-disk-utility
    gnome-font-viewer
    gnome-logs
    gnome-text-editor
    loupe
    nautilus
    simple-scan

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
    cliphist
    hypridle
    hyprpaper
    hyprpicker
    hyprpolkitagent
    nwg-look
    pavucontrol
    playerctl
    rofi-power-menu

    # Screenshot
    grim
    slurp
  ];

  programs.tmux.enable = true;

  programs.kitty = {
    enable = true;
    themeFile = "Hybrid";
    settings = {
      font_family = "HackNerdFont";
      font_size = 12;
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
