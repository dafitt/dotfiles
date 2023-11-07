{ config, ... }: {

  # Modern and intuitive terminal-based text editor
  # https://micro-editor.github.io/
  programs.micro = {
    enable = true;
    settings = {
      colorscheme = "simple";
      mkparents = true;
      softwrap = true;
      tabmovement = true;
      tabsize = 4;
      tabstospaces = true;
      autosu = true;
    };
  };

  wayland.windowManager.hyprland.settings = {
    bind = [ "ALT SUPER, T, exec, $TERMINAL -e $EDITOR" ];
  };
}
