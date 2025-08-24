{
  config,
  lib,
  pkgs,
  ...
}:

with lib;
with lib.dafitt;
let
  cfg = config.dafitt.shells;
in
{
  options.dafitt.shells = with types; {
    default = mkOption {
      type = nullOr (enum [
        "bash"
        "fish"
      ]);
      default = null;
      description = "Which shell will be used primarily.";
    };
  };

  config.dafitt.shells = {
    fish = mkIf (cfg.default == "fish") {
      enable = true;
      configureAsDefault = true;
    };
  };
}
