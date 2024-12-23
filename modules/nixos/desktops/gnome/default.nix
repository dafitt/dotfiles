{ options, config, lib, pkgs, ... }:

with lib;
with lib.dafitt;
let
  cfg = config.dafitt.desktops.gnome;

  custom-gnome-session = with pkgs; stdenv.mkDerivation rec {
    name = "custom-gnome-session";
    dontUnpack = true;

    desktopFile = makeDesktopItem {
      name = "gnome";
      desktopName = "GNOME";
      exec = "${custom-gnome-session_wayland-startScript}/bin/custom-gnome-session_wayland-startScript";
      terminal = true;
    };

    custom-gnome-session_wayland-startScript = writeShellScriptBin "custom-gnome-session_wayland-startScript" ''
      export XDG_SESSION_TYPE=wayland
      ${pkgs.dbus}/bin/dbus-run-session ${pkgs.gnome.gnome-session}/bin/gnome-session
    '';

    installPhase = ''
      mkdir -p $out/share/wayland-sessions
      cp $desktopFile/share/applications/*.desktop $out/share/wayland-sessions/
    '';
  };
in
{
  options.dafitt.desktops.gnome = with types; {
    enable = mkBoolOpt false "Whether to enable the Gnome desktop environment.";
  };

  config = mkIf cfg.enable {
    services.xserver.desktopManager.gnome.enable = true;

    services.udev.packages = [ pkgs.gnome-settings-daemon ];

    dafitt.displayManager.greetd.sessionPaths = [ "${custom-gnome-session}/share/wayland-sessions" ];
  };
}
