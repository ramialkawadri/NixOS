{ ... }:
{
  services.hyprpaper = {
    enable = true;
    settings = {
      preload = [ "${../imgs/background2.jpg}" ];
      wallpaper = [ ",${../imgs/background2.jpg}" ];
    };
  };
}
