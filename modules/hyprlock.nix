{ ... }:
{
  programs.hyprlock = {
    enable = true;
    settings = {
      general = {
        grace = 2;
        hide_cursor = false;
      };

      background = [
        {
          path = "${../imgs/background.jpg}";
          blur_passes = 2;
          blur_size = 4;
        }
      ];

      label = [
        {
          text = "$TIME";
          color = "rgb(c3c3c3)";
          font_size = 78;
          font_family = "HackNerdFont";
          position = "0, 160";
          shadow_passes = 4;
        }
      ];

      input-field = [
        {
          size = "460, 45";
          font_family = "HackNerdFont";
          inner_color = "#ffffff";
          outer_color = "#000000";
          placeholder_text = ''<span foreground="##000">Password...</span>'';
          shadow_passes = 4;
          fade_on_empty = false;
        }
      ];
    };
  };
}
