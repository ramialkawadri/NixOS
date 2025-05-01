{ ... }:
{
  services.hyprpaper = {
    enable = true;
    settings = {
      preload = [ "~/Pictures/NixOS/background.jpg" ];
      wallpaper = [ ",~/Pictures/NixOS/background.jpg" ];
    };
  };
}
