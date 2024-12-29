{ options, config, lib, pkgs, ... }:

with lib;
with lib.dafitt;
let
  cfg = config.dafitt.latex;
in
{
  options.dafitt.latex = with types; {
    enable = mkEnableOption "latex editing"; # disabled by default because of very large download size (~6GB)
  };

  config = mkIf cfg.enable {
    services.flatpak = {
      packages = [
        { appId = "app.gummi.gummi"; origin = "flathub"; } # simple and fast LaTeX editor
        { appId = "org.texstudio.TeXstudio"; origin = "flathub"; } # more feature-rich LaTeX editor
        { appId = "fyi.zoey.TeX-Match"; origin = "flathub"; } # find LaTeX symbols by sketching
      ];
      overrides = {
        "app.gummi.gummi".Context.filesystems = [ "home" ];
      };
    };
  };
}
