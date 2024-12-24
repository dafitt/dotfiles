{ options, config, lib, pkgs, ... }:

with lib;
with lib.dafitt;
let
  cfg = config.dafitt.hyprland.notifications;
  enabledSubModules = filter (n: cfg.${n}.enable or false) (attrNames cfg);
in
{
  options.dafitt.hyprland.notifications = with types; {
    enable = mkOpt (nullOr (enum [ "hyprnotify" "mako" ])) null "Which network manager to use.";
  };

  config = {
    assertions = [{
      assertion = length enabledSubModules <= 1;
      message = "${toString ./.}: Only one submodule can be enabled. Currently enabled: ${concatStringsSep ", " enabledSubModules}";
    }];
  };
}
