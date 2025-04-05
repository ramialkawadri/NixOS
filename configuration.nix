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

  # Kernel
  boot.kernel.sysctl = { "vm.swappiness" = 4; };
  boot.kernelPackages = pkgs.linuxPackages_latest;
  boot.kernelParams = [ "quiet" "acpi_osi=\"!Windows 2015\"" ];
  boot.blacklistedKernelModules = [ "uvcvideo" "nouveau" ];

  # Networking
  networking.hostName = "ramikw";
  networking.networkmanager.enable = true;
  networking.firewall.enable = true;

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
    description = "ramikw";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = [];
  };

  # Packages
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nixpkgs.config.allowUnfree = true;
  services.displayManager.sddm.enable = true;
  services.desktopManager.plasma6.enable = true;
  services.flatpak.enable = true;
  environment.systemPackages = with pkgs; [
    htop
    lshw
    neofetch
    pciutils
    ripgrep
    unzip
    vimPlugins.nvim-treesitter.withAllGrammars
    wget
    wl-clipboard
    zsh-powerlevel10k
  ];
  fonts.packages = with pkgs; [ 
    corefonts
    nerd-fonts.hack
  ];
  programs._1password.enable = true;
  programs._1password-gui.enable = true;
  programs.partition-manager.enable = true;
  programs.neovim = {
    enable = true;
    defaultEditor = true;
  };

  # Firefox
  programs.firefox = {
    enable = true;
    preferences = {
      "widget.use-xdg-desktop-portal.file-picker" = 1;
      "widget.use-xdg-desktop-portal.mime-handler" = 1;
    };
  };

  # Other settings
  services.cron.enable = true;
  hardware.bluetooth.enable = true;
  hardware.logitech.wireless.enable = true;
  xdg.portal.enable = true;

  # Environment variables
  environment.sessionVariables = {
    QT_SCALE_FACTOR = 1;
    GTK_USE_PORTAL = 1;
    NIXOS_OZONE_WL = 1;
  };

  # Printing
  services.printing.enable = true;
  services.avahi = {
    enable = true;
    nssmdns4 = true;
    openFirewall = true;
  };

  # Zsh
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestions.enable = true;
    syntaxHighlighting.enable = true;
    shellAliases = {
      update = "sudo nixos-rebuild switch && reload-apps";
      upgrade = "sudo nix flake update && sudo nixos-rebuild switch --upgrade && reload-apps";
      clean = "sudo nix-collect-garbage --delete-old; sudo /run/current-system/bin/switch-to-configuration boot";
      reload-apps = "sed -i 's/file:\\/\\/\\/nix\\/store\\/[^\\/]*\\/share\\/applications\\//applications:/gi' ~/.config/plasma-org.kde.plasma.desktop-appletsrc && systemctl restart --user plasma-plasmashell";
      tx = "tmuxinator";
    };
    histSize = 10000;
    ohMyZsh = {
      enable = true;
      plugins = ["tmux" "git" "man" "colored-man-pages" "colorize" "command-not-found"];
    };
    promptInit = "source ${pkgs.zsh-powerlevel10k}/share/zsh-powerlevel10k/powerlevel10k.zsh-theme";
  };
  users.defaultUserShell = pkgs.zsh;

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

  # Nvidia-driver
  services.xserver.videoDrivers = ["nvidia"];
  hardware.nvidia = {
    modesetting.enable = true;
    powerManagement.enable = true;
    open = false;
    nvidiaSettings = true;
    package = config.boot.kernelPackages.nvidiaPackages.latest;
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

  # This and the kernal param "acpi_osi=\"!Windows 2015\"" fixes sleep issues for Gigabyte.
  # https://wiki.archlinux.org/title/Power_management/Wakeup_triggers#Gigabyte_motherboards
  services.udev.extraRules = ''
      ACTION=="add" SUBSYSTEM=="pci" ATTR{vendor}=="0x1022" ATTR{device}=="0x1483" ATTR{power/wakeup}="disabled"
  '';

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.11"; # Did you read the comment?
}
