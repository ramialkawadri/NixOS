{ config, pkgs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
    ];

  # Bootloader
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.grub = {
    enable = true;
    device = "nodev";
    useOSProber = true;
    efiSupport = true;
  };
  boot.plymouth.enable = true;
  boot.kernelPackages = pkgs.linuxPackages_latest;
  boot.kernel.sysctl = { "vm.swappiness" = 10; };

  # Networking
  networking.hostName = "Ramikw";
  networking.networkmanager.enable = true;

  # Language
  time.timeZone = "Europe/Oslo";
  i18n.defaultLocale = "en_US.UTF-8";
  console.keyMap = "no";
  services.xserver.xkb = {
    layout = "no";
    variant = "";
  };

  # Other
  users.users.ramikw = {
    isNormalUser = true;
    description = "Ramikw";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = [];
  };

  # Packages
  nixpkgs.config.allowUnfree = true;
  services.displayManager.sddm.enable = true;
  services.desktopManager.plasma6.enable = true;
  environment.systemPackages = with pkgs; [
    lshw
    neofetch
    pciutils
    ripgrep
    tmux
    tmuxinator
    unzip
    wget
    wl-clipboard
    zsh-powerlevel10k

    delta
    dotnet-sdk
    gcc
    htop
    jdk
    lazygit
    neovim
    nodejs_23
    postman
    python314
    rustup
    texliveFull

    _1password-cli
    _1password-gui
    anki
    discord
    drawio
    firefox
    kdePackages.kclock
    libreoffice
    megasync
    solaar
    thunderbird
    vlc
    vscode
  ];
  fonts.packages = with pkgs; [ 
    (nerdfonts.override { fonts = [ "Hack" ]; })
  ];
  programs.partition-manager.enable = true;

  # Other settings
  services.cron.enable = true;
  networking.firewall.enable = true;
  hardware.bluetooth.enable = true;

  # Environment variables
  environment.sessionVariables = {
    QT_QPA_PLATFORM = "wayland";
    QT_SCALE_FACTOR = 1;
  };
  environment.variables = {
    EDITOR = "nvim";
  };

  # Printing
  services.printing.enable = true;
  services.avahi = {
    enable = true;
    nssmdns4 = true;
    openFirewall = true;
  };

  # Git
  programs.git = {
    enable = true;
    config = {
      user.name  = "Rami Alkawadri";
      user.email = "ramialkawadri@hotmail.com";
      credential.helper = "store";
      delta = {
        line-numbers = true;
        paging = "never";
        dark = true;
        syntax-theme = "Visual Studio Dark+";
        side-by-side = true;
      };
    };
  };

  # Zsh
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestions.enable = true;
    syntaxHighlighting.enable = true;
    shellAliases = {
      update = "sudo nixos-rebuild switch";
      clean = "sudo nix-collect-garbage --delete-old; sudo /run/current-system/bin/switch-to-configuration boot";
    };
    histSize = 10000;
    ohMyZsh = {
      enable = true;
      plugins = ["git" "man" "colored-man-pages" "colorize" "command-not-found"];
    };
    promptInit = "source ${pkgs.zsh-powerlevel10k}/share/zsh-powerlevel10k/powerlevel10k.zsh-theme";
  };
  users.defaultUserShell = pkgs.zsh;

  # Nvidia-driver
  services.xserver.videoDrivers = ["nvidia"];
  hardware.nvidia = {
    modesetting.enable = true;
    powerManagement.enable = false;
    open = false;
    nvidiaSettings = true;
    package = config.boot.kernelPackages.nvidiaPackages.stable;
  };

  # Pipewire
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    jack.enable = true;
    pulse.enable = true;
    socketActivation = true;
  };

  # Automatic Garbage Collection
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 7d";
  };

  # Auto system update
  system.autoUpgrade = {
    enable = true;
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.11"; # Did you read the comment?
}
