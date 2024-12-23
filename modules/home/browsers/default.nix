{ options, config, lib, pkgs, osConfig ? { }, ... }:

with lib;
with lib.dafitt;
let
  cfg = config.dafitt.browsers;
in
{
  options.dafitt.browsers = with types; {
    default = mkOpt (nullOr (enum [ "epiphany" "firefox" "librewolf" ])) "firefox" "Which web browser is to be used primarily.";
    autostart = mkBoolOpt true "Start the web browser on login.";
  };
}
