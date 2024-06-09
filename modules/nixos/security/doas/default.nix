{ options, config, lib, pkgs, ... }:

with lib;
with lib.dafitt;
let
  cfg = config.dafitt.security.doas;
in
{
  options.dafitt.security.doas = with types;{
    enable = mkBoolOpt false "Whether or not to replace sudo with doas.";
  };

  config = mkIf cfg.enable {
    #security.sudo.enable = false;
    security.doas.enable = true;

    #environment.shellAliases = { sudo = "doas"; };
  };
}
