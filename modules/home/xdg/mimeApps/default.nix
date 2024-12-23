{ options, config, lib, pkgs, ... }:

with lib;
with lib.dafitt;
let
  cfg = config.dafitt.xdg.mimeApps;
in
{
  options.dafitt.xdg.mimeApps = with types; {
    enable = mkBoolOpt false "Whether to set default applications for mime types.";
  };

  config = mkIf cfg.enable {
    xdg.mimeApps.enable = true;

    #xdg.mimeApps.defaultApplications = { };
    # Those are scattered across the applications

    # Take from the respective mimetype files
    # https://wiki.archlinux.org/title/Xdg-utils#xdg-mime
    #$ xdg-mime query filetype

    # Where to find .desktop-files
    #$ find -L / -name "*.desktop" 2>/dev/null
    #$ ls /run/current-system/sw/share/applications
    #$ ls ~/.local/state/nix/profiles/home-manager/home-path/share/applications
    #$ ls ~/.local/share/flatpak/exports/share/applications/
  };
}
