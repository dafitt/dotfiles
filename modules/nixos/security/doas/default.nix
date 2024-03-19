{ options, config, lib, pkgs, ... }:

with lib;
with lib.custom;
let
  cfg = config.custom.security.doas;
in
{
  options.custom.security.doas = {
    enable = mkBoolOpt false "Whether or not to replace sudo with doas.";
  };

  config = mkIf cfg.enable {
    #security.sudo.enable = false;
    security.doas.enable = true;

    #environment.shellAliases = { sudo = "doas"; };
  };
}
