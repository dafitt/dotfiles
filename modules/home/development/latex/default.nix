{ options, config, lib, pkgs, ... }:

with lib;
with lib.dafitt;
let
  cfg = config.dafitt.development.latex;
in
{
  options.dafitt.development.latex = with types; {
    enable = mkBoolOpt false "Enable latex editing"; # disabled by default because of very large download size (~6GB)
  };

  config = mkIf cfg.enable {
    services.flatpak = {
      packages = [
        { appId = "app.gummi.gummi"; origin = "flathub"; } # LaTeX Editor
        { appId = "fyi.zoey.TeX-Match"; origin = "flathub"; } # find LaTeX symbols by sketching

        #{ appId = "org.cvfosammmm.Setzer"; origin = "flathub"; } # LaTeX Editor
      ];

      overrides = {
        "app.gummi.gummi".Context.filesystems = [ "home" ];
      };
    };
  };
}
