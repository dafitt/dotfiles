{ options, config, lib, pkgs, osConfig ? { }, ... }:

with lib;
with lib.dafitt;
let
  cfg = config.dafitt.browsers;
in
{
  options.dafitt.browsers = with types; {
    autostart = mkBoolOpt true "Start the web browser on login.";

    default = mkOption {
      type = nullOr (enum [ "epiphany" "firefox" "librewolf" ]);
      default = null;
      description = "Which web browser will be used primarily.";
    };
  };
}
