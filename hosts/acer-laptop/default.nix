{
  ...
}:
{
  imports = [
    ./hardware-configuration.nix
  ];

  services.auto-cpufreq.enable = true;
}

