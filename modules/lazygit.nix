{ ... }:
{
  programs.lazygit = {
    enable = true;

    settings = {
      os.editPreset = "nvim";

      git = {
        paging = {
          colorArg = "always";
          pager = "delta";
        };
      };

    };
  };
}
