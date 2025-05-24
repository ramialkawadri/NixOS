{ config, pkgs, lib, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
      ./modules/git.nix
    ];

  # Bootloader
  boot = {
    loader.efi.canTouchEfiVariables = true;
    loader.grub = {
      enable = true;
      device = "nodev";
      useOSProber = true;
      efiSupport = true;
    };
    plymouth.enable = true;
  };

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
    extraGroups = [ "networkmanager" "wheel" "input" ];
    packages = [];
  };
  programs.zsh.enable = true;
  users.defaultUserShell = pkgs.zsh;

  # Packages
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nixpkgs.config.allowUnfree = true;
  services.flatpak.enable = true;
  environment.systemPackages = with pkgs; [
    htop
    kitty
    lshw
    neofetch
    pciutils
    ripgrep
    tldr
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

  # Hyprland
  programs.hyprland.enable = true;
  services.displayManager.sddm = {
    enable = true;
    wayland.enable = true;
    sugarCandyNix = {
      enable = true;
      settings = {
        Background = lib.cleanSource ./imgs/background.jpg;
        DimBackgroundImage = 0.4;
        ScaleImageCropped = true;
        ScreenWidth = 2560;
        ScreenHeight = 1440;
        Font = "HackNerdFont";
        RoundCorners = 6;
        AccentColor = "#80a1be";
      };
    };
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

  # Nvidia-driver
  services.xserver.videoDrivers = [ "nvidia" ];
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
    ACTION=="add", SUBSYSTEM=="pci", DRIVER=="pcieport", ATTR{power/wakeup}="disabled"
    ACTION=="add" SUBSYSTEM=="pci" ATTR{vendor}=="0x1022" ATTR{device}=="0x1483" ATTR{power/wakeup}="disabled"
  '';

  services.solaar = {
    enable = true;
    package = pkgs.solaar;
    window = "hide";
    batteryIcons = "regular";
    extraArgs = "";
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.11"; # Did you read the comment?
}
