{ ... }:
{
  services.kanata = {
    enable = true;
    keyboards.main = {
      config = ''
        (defsrc
          caps s d f
          h j k l
        )

        (defvar
          tap-time 250
          hold-time 200
        )

        (deflayer default
          @cap _ _ _
          _ _ _ _
        )

        (deflayer arrows
          _ lctrl lmet lalt
          left down up rght
        )

        (defalias
          cap (tap-hold-press $tap-time $hold-time esc (layer-toggle arrows))
        )
      '';

      extraDefCfg = ''
        process-unmapped-keys yes
      '';
    };
  };
}
