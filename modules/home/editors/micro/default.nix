{
  config,
  lib,
  pkgs,
  ...
}:

with lib;
with lib.dafitt;
let
  cfg = config.dafitt.micro;
in
{
  options.dafitt.micro = with types; {
    enable = mkEnableOption "`micro`";
    setAsDefaultEditor = mkEnableOption "making it the default EDITOR";
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
      icon = "micro.svg";
      genericName = "Text Editor";
      comment = "Edit text files in a terminal";
      exec = "${pkgs.micro}/bin/micro %F";
      terminal = true;
      startupNotify = false;
      type = "Application";
      categories = [
        "Utility"
        "TextEditor"
        "Development"
      ];
      mimeType = [
        "text/plain"
        "text/x-chdr"
        "text/x-csrc"
        "text/x-c++hdr"
        "text/x-c++src"
        "text/x-java"
        "text/x-dsrc"
        "text/x-pascal"
        "text/x-perl"
        "text/x-python"
        "application/x-php"
        "application/x-httpd-php3"
        "application/x-httpd-php4"
        "application/x-httpd-php5"
        "application/xml"
        "text/html"
        "text/css"
        "text/x-sql"
        "text/x-diff"
      ];

      settings = {
        Keywords = "text;editor;syntax;terminal;";
      };
    };

    home.sessionVariables.EDITOR = mkIf cfg.setAsDefaultEditor (getExe config.programs.micro.package);

    wayland.windowManager.hyprland.settings = {
      bind = mkIf cfg.setAsDefaultEditor [
        "SUPER_ALT, E, exec, uwsm app -- ${getExe pkgs.kitty} -e ${pkgs.micro}/bin/micro"
      ];
    };
  };
}
