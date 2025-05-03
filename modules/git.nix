{ ... }:
{
  programs.git = {
    enable = true;
    config = {
      user.name  = "Rami Alkawadri";
      user.email = "ramialkawadri@hotmail.com";
      credential.helper = "store";

      interactive = {
        diffFilter = "delta --color-only";
      };

      delta = {
        line-numbers = true;
        paging = "never";
        dark = true;
        syntax-theme = "Visual Studio Dark+";
        side-by-side = true;
        hyprlinks = true;
      };
    };
  };
}
