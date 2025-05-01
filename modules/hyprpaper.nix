{ ... }:
{
  services.hyprpaper = {
    enable = true;
    settings = {
      preload = [ "${../imgs/background.jpg}" ];
      wallpaper = [ ",${../imgs/background.jpg}" ];
    };
  };
}
