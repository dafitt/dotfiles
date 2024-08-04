{ options, config, lib, pkgs, ... }:

with lib;
with lib.dafitt;
let
  cfg = config.dafitt.APPLICATION;
in
{
  options.dafitt.APPLICATION = with types; {
    enable = mkBoolOpt false "Enable APPLICATION.";
    autostart = mkBoolOpt false "Start APPLICATION on login";
    defaultApplication = mkBoolOpt true "Set APPLICATION as the default application for its mimetypes.";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [ APPLICATION ];
    environment.systemPackages = with pkgs; [ APPLICATION ];

    programs.APPLICATION.enable = true;

    xdg.mimeApps.defaultApplications = mkIf cfg.defaultApplication (listToAttrs (map (mimeType: { name = mimeType; value = [ "APPLICATION.desktop" ]; }) [
      #$ ls /run/current-system/sw/share/applications

      #$ xdg-mime query filetype
      #"application/mimetype"
    ]));

    wayland.windowManager.hyprland.settings = {
      exec = [ ];
      exec-once = mkIf cfg.autostart [ ];
      binds = [ ];
      windowrulev2 = [ ];
    };
  };
}
