{ options, config, lib, pkgs, ... }:

with lib;
with lib.dafitt;
let
  cfg = config.dafitt.editor.micro;
in
{
  options.dafitt.editor.micro = with types; {
    enable = mkBoolOpt (config.dafitt.editor.default == "micro") "Enable the micro terminal text editor";
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

    # https://github.com/zyedidia/micro/blob/master/assets/packaging/micro.desktop
    xdg.desktopEntries.micro = {
      name = "Micro";
      icon = ./micro-logo-mark.svg;
      genericName = "Text Editor";
      comment = "Edit text files in a terminal";

      type = "Application";
      exec = "${pkgs.micro}/bin/micro %F";
      terminal = true;
      startupNotify = false;
      mimeType = [ "text/plain" "text/x-chdr" "text/x-csrc" "text/x-c++hdr" "text/x-c++src" "text/x-java" "text/x-dsrc" "text/x-pascal" "text/x-perl" "text/x-python" "application/x-php" "application/x-httpd-php3" "application/x-httpd-php4" "application/x-httpd-php5" "application/xml" "text/html" "text/css" "text/x-sql" "text/x-diff" ];
      categories = [ "Utility" "TextEditor" "Development" ];

      settings = {
        Keywords = "text;editor;syntax;terminal;";
      };
    };

    home.sessionVariables.EDITOR = mkIf (config.dafitt.editor.default == "micro") "${pkgs.micro}/bin/micro"; # TODO: upstream programs.micro.package = pkgs.micro;
  };
}
