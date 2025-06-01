{ ... }:
{
  services.kanata = {
    enable = true;
    keyboards.main = {
      config = ''
        (defsrc
          caps
          a s d f h j k l ;
        )

        (deflayer base
          @caps
          @a  @s  @d  @f  @h  @j  @k  @l  @;
        )

        (defvar
          tap-time  155
          hold-time 155
        )

        (defalias
          caps (tap-dance 200 (esc caps))
          a (tap-hold $tap-time $hold-time a lalt)
          s (tap-hold $tap-time $hold-time s lsft)
          d (tap-hold $tap-time $hold-time d lctl)
          f (tap-hold $tap-time $hold-time f lmet)

          j (tap-hold $tap-time $hold-time j rmet)
          k (tap-hold $tap-time $hold-time k rctl)
          l (tap-hold $tap-time $hold-time l rsft)
          ; (tap-hold $tap-time $hold-time ; ralt)

          h (tap-dance $tap-time (h enter))
        )
      '';

      extraDefCfg = ''
        process-unmapped-keys yes
      '';
    };
  };
}
