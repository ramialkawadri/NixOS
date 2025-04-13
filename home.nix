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

  home.file.".config/katerc" = {
    source = ./dotfiles/katerc;
    force = true;
  };

  home.file.".config/okularpartrc" = {
    source = ./dotfiles/okularpartrc;
    force = true;
  };

  home.file.".config/kglobalshortcutsrc" = {
    source = ./dotfiles/kglobalshortcutsrc;
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
    kdePackages.kcalc
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
  ];


  programs.tmux = {
    enable = true;
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
