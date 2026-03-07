{ ... }:
{
  home.file.".config/vlc" = {
    source = ./config;
    recursive = true;
    force = true;
  };
}
