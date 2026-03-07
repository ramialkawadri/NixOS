{ ... }:
{
  programs.lazygit = {
    enable = true;

    settings = {
      os.editPreset = "nvim";

      git = {
        pager = [
          {
            colorArg = "always";
            pager = "delta";
          }
        ];
      };

    };
  };
}
