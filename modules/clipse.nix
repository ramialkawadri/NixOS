{ ... }: {
  services.clipse = {
    enable = true;
    imageDisplay = {
      type = "kitty";
      scaleX = 15;
      scaleY = 15;
    };
  };
}
