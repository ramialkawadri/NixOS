{ lib, ... }:
{
  xdg = {
    enable = true;
    userDirs.enable = true;
    mimeApps = {
      enable = true;
      defaultApplications = lib.mkBefore {
        "application/pdf" = [ "brave-browser.desktop" ];
        "x-scheme-handler/http" = [ "brave-browser.desktop" ];
        "x-scheme-handler/https" = [ "brave-browser.desktop" ];
        "x-scheme-handler/chrome" = [ "brave-browser.desktop" ];
        "text/html" = [ "brave-browser.desktop" ];
        "application/x-extension-htm" = [ "brave-browser.desktop" ];
        "application/x-extension-html" = [ "brave-browser.desktop" ];
        "application/x-extension-shtml" = [ "brave-browser.desktop" ];
        "application/xhtml+xml" = [ "brave-browser.desktop" ];
        "application/x-extension-xhtml" = [ "brave-browser.desktop" ];
        "application/x-extension-xht" = [ "brave-browser.desktop" ];
        "x-scheme-handler/about" = [ "brave-browser.desktop" ];
        "x-scheme-handler/unknown" = [ "brave-browser.desktop" ];

        # Images
        "image/jpeg" = [ "org.gnome.Loupe.desktop" ];
        "image/png" = [ "org.gnome.Loupe.desktop" ];
        "image/gif" = [ "org.gnome.Loupe.desktop" ];
        "image/webp" = [ "org.gnome.Loupe.desktop" ];
        "image/tiff" = [ "org.gnome.Loupe.desktop" ];
        "image/bmp" = [ "org.gnome.Loupe.desktop" ];
        "image/svg+xml" = [ "org.gnome.Loupe.desktop" ];
        "image/avif" = [ "org.gnome.Loupe.desktop" ];
        "image/heic" = [ "org.gnome.Loupe.desktop" ];

        # Videos
        "video/mp4" = [ "mpv.desktop" ];
        "video/mkv" = [ "mpv.desktop" ];
        "video/webm" = [ "mpv.desktop" ];
        "video/avi" = [ "mpv.desktop" ];
        "video/mov" = [ "mpv.desktop" ];
        "video/wmv" = [ "mpv.desktop" ];
        "video/flv" = [ "mpv.desktop" ];
        "video/mpeg" = [ "mpv.desktop" ];
        "video/x-matroska" = [ "mpv.desktop" ];
        "video/quicktime" = [ "mpv.desktop" ];
        "video/x-msvideo" = [ "mpv.desktop" ];
      };
    };
  };
}
