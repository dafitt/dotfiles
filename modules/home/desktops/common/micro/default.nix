{ options, config, lib, pkgs, ... }:

with lib;
with lib.custom;
let
  cfg = config.custom.desktops.common.micro;
in
{
  options.custom.desktops.common.micro = with types; {
    enable = mkBoolOpt config.custom.desktops.common.enable "Enable the micro text editor";
  };

  config = mkIf cfg.enable {
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
  };
}
