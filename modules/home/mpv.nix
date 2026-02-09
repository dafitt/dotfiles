{
  #meta.doc = builtins.toFile "doc.md" ''
  #  Installs and configures MPV, a free and open-source media player.
  #  <https://mpv.io/>
  #'';

  programs.mpv.enable = true;

  wayland.windowManager.hyprland.settings = {
    windowrule = [
      "match:class mpv$, idle_inhibit focus"
    ];
  };
}
