{ pkgs, config, ... }: {

  # ElKowar's Wacky Widgets
  # https://github.com/elkowar/eww
  programs.eww-personal = {
    # eww guide https://dharmx.is-a.dev/eww-powermenu/
    # configuration doc <https://elkowar.github.io/eww/configuration.html>
    # widgets doc <https://elkowar.github.io/eww/widgets.html>
    # a good example <https://github.com/end-4/dots-hyprland/tree/m3ww>
    enable = true;

    #manualSymlinked = true;
  };
}
