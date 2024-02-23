{ config, ... }: {

  # Modern and intuitive terminal-based text editor
  # https://micro-editor.github.io/
  programs.micro = {
    enable = true;
    settings = {
      # https://github.com/zyedidia/micro/blob/master/runtime/help/options.md
      colorscheme = "simple";
      mkparents = true;
      softwrap = true;
      tabmovement = true;
      tabsize = 4;
      tabstospaces = true;
      autosu = true;
      eofnewline = false;
    };
  };
}
