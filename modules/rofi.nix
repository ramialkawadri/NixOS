{ pkgs, ... }:
{
  programs.rofi = {
    enable = true;
    package = pkgs.rofi-wayland;
    font = "HackNerdFont 14";
    theme = ../dotfiles/rofi/theme.rasi;
    plugins = [ pkgs.rofi-emoji-wayland ];
    extraConfig = {
      modi = "drun,run,filebrowser";
      case-sensitive = false;
      cycle = true;
      filter = "";
      show-icons = true;
      display-drun = "";
      hover-select = true;
    };
  };
}
