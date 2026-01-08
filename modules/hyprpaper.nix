{ ... }:
{
  services.hyprpaper = {
    enable = true;
    settings = {
      splash = false;
      wallpaper = [
        {
          monitor = "";
          path = "${../imgs/background2.jpg}";
        }
      ];
    };
  };
}
