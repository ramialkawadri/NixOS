{ ... }:
{
  services.dunst = {
    enable = true;
    settings = {
        global = {
            font = "HackNerdFont 12";
            foreground = "#eee";
            frame_color = "#58a4e9";
            separator_color= "frame";
            background = "#000";
            monitor = 0;
            follow = "mouse";
            width = 320;
            height = 320;
            origin = "top-right";
            offset = "15x15";
            scale = 0;
            notification_limit = 0;
            progress_bar = false;
            indicate_hidden = "yes";
            transparency = 0;
            separator_height = 2;
            padding = "10";
            horizontal_padding = 10;
            text_icon_padding = 0;
            frame_width = 4;
            gap_size = 0;
            sort = "yes";
            idle_threshold = 120;
            line_height = 0;
            markup = "yes";
            plain_text = "no";
            format = "<b>%s</b>\n%b";
            alignment = "left";
            vertical_alignment = "center";
            show_age_threshold = 60;
            ellipsize = "middle";
            ignore_newline = "no";
            stack_duplicates = "true";
            hide_duplicate_count = "false";
            show_indicators = "yes";
            icon_position = "left";
            min_icon_size = 0;
            max_icon_size = 32;
            sticky_history = "yes";
            history_length = 20;
            always_run_script = true;
            corner_radius = 6;
            ignore_dbusclose = false;
            force_xinerama = false;
            mouse_left_click = "close_current";
            mouse_middle_click = "do_action, close_current";
            mouse_right_click = "close_all";
        };
        urgency_critical = {
            background = "#d64e4e";
            foreground = "#f0e0e0";
            frame_color = "#d64e4e";
            timeout = 0;
        };
    };
  };
}
