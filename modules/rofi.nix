{ pkgs, ... }:
{
  programs.rofi = {
    enable = true;
    package = pkgs.rofi;
    font = "HackNerdFont 13";
    theme = ../dotfiles/rofi/theme.rasi;
    plugins = [ pkgs.rofi-emoji ];
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
