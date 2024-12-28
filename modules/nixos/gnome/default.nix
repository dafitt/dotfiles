{ options, config, lib, pkgs, ... }:

with lib;
with lib.dafitt;
let
  cfg = config.dafitt.gnome;

  gnomeBackupSessionScript = pkgs.writeShellScriptBin "gnomeBackupSessionScript" ''
    export XDG_SESSION_TYPE=wayland
    ${pkgs.dbus}/bin/dbus-run-session ${pkgs.gnome-session}/bin/gnome-session
  '';
  gnomeBackupSession = pkgs.makeDesktopItem {
    name = "gnome-backup-session";
    desktopName = "GNOME (backup)";
    exec = "${gnomeBackupSessionScript}/bin/gnomeBackupSessionScript";
    terminal = true;
  };
in
{
  options.dafitt.gnome = with types; {
    enable = mkBoolOpt false "Whether to enable the Gnome desktop environment.";
  };

  config = mkIf cfg.enable {
    dafitt.displayManager.sessionPaths = [ "${gnomeBackupSession}/share/applications" ];

    services.xserver.desktopManager.gnome.enable = true;
    services.udev.packages = [ pkgs.gnome-settings-daemon ];
  };
}
