{ ... }:
{
  home.file."Pictures/NixOS" = {
    source = ./imgs;
    recursive = true;
    force = true;
  };

  services.hyprpaper = {
    enable = true;
    settings = {
      splash = false;
      wallpaper = [
        {
          monitor = "";
          path = "${./imgs/background2.jpg}";
        }
      ];
    };
  };
}
