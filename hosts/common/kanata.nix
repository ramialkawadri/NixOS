{ ... }:
{
  services.kanata = {
    enable = true;
    keyboards.main = {
      config = ''
        (defsrc
          caps
        )

        (deflayer base
          @caps
        )

        (defalias
          caps (tap-dance 200 (esc caps))
        )
      '';

      extraDefCfg = ''
        process-unmapped-keys yes
      '';
    };
  };
}
