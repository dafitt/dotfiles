{ options, config, lib, pkgs, ... }:

with lib;
with lib.dafitt;
let
  cfg = config.dafitt.gnome;

  backup-gnome-session = with pkgs; stdenv.mkDerivation rec {
    name = "backup-gnome-session";
    dontUnpack = true;

    backup-gnome-session_wayland-startScript = writeShellScriptBin "backup-gnome-session_wayland-startScript" ''
      export XDG_SESSION_TYPE=wayland
      ${pkgs.dbus}/bin/dbus-run-session ${pkgs.gnome-session}/bin/gnome-session
    '';

    desktopFile = makeDesktopItem {
      name = "gnome-backup-session";
      desktopName = "GNOME (backup)";
      exec = "${backup-gnome-session_wayland-startScript}/bin/backup-gnome-session_wayland-startScript";
      terminal = true;
    };

    installPhase = ''
      mkdir -p $out/share/wayland-sessions
      cp $desktopFile/share/applications/*.desktop $out/share/wayland-sessions/
    '';
  };
in
{
  options.dafitt.gnome = with types; {
    enable = mkBoolOpt false "Whether to enable the Gnome desktop environment.";
  };

  config = mkIf cfg.enable {
    services.xserver.desktopManager.gnome.enable = true;

    services.udev.packages = [ pkgs.gnome-settings-daemon ];

    dafitt.displayManager.sessionPaths = [ "${backup-gnome-session}/share/wayland-sessions" ];
  };
}
