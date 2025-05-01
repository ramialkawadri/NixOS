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
          path = "~/Pictures/NixOS/background.jpg";
          blur_passes = 2;
          blur_size = 4;
        }
      ];

      label = [
        {
          text = "$TIME";
          color = "rgb(c3c3c3)";
          font_size = 96;
          font_family = "HackNerdFont";
          position = "0, 160";
          shadow_passes = 4;
        }
      ];

      input-field = [
        {
          size = "500, 50";
          font_family = "HackNerdFont";
          inner_color = "#ffffff";
          outer_color = "#000000";
          placeholder_text = ''<span foreground="##000">Password...</span>'';
          shadow_passes = 4;
        }
      ];
    };
  };
}
