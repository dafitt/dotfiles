{
  programs.btop = {
    enable = true;
    settings = {
      theme_background = false;
    };
  };

  wayland.windowManager.hyprland.settings = {
    windowrulev2 = [
      "float, title:^btop$, class:kitty"
      "size 90% 90%, title:^btop$"
      "minsize 800 530, title:^btop$"
      "center, title:^btop$"
    ];
  };
}
