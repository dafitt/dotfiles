{ options, config, lib, pkgs, ... }:

with lib;
with lib.custom;
let
  cfg = config.custom.APPLICATION;
in
{
  options.custom.APPLICATION = with types; {
    enable = mkBoolOpt false "Enable APPLICATION";
    defaultApplication = mkBoolOpt true "Set APPLICATION as the default application for its mimetypes";
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
      exec-once = [ ];
      binds = [ ];
      windowrulev2 = [ ];
    };
  };
}
