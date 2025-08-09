{ ... }:
{
  dconf.settings = {
    "org/gnome/desktop/interface".color-scheme = "prefer-light";
    "org/gnome/desktop/wm/preferences".button-layout = "";
  };

  gtk = {
    enable = true;
    gtk3 = {
      extraConfig = {
        gtk-application-prefer-dark-theme = 0;
      };
    };

    gtk4 = {
      extraConfig = {
        gtk-application-prefer-dark-theme = 0;
      };
    };
  };

  qt = {
    enable = true;
    platformTheme.name = "Adwaita";
    style.name = "Adwaita";
  };
}
