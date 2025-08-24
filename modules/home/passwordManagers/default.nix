{ config, lib, ... }:

with lib;
with lib.dafitt;
let
  cfg = config.dafitt.passwordManagers;
in
{
  options.dafitt.passwordManagers = with types; {
    default = mkOption {
      type = nullOr (enum [
        "_1password"
        "bitwarden"
      ]);
      default = null;
      description = "Which password manager will be used primarily.";
    };
  };

  config.dafitt.passwordManagers = {
    _1password = mkIf (cfg.default == "_1password") {
      enable = true;
      configureKeybindings = true;
    };
    bitwarden = mkIf (cfg.default == "bitwarden") {
      enable = true;
      configureKeybindings = true;
    };
  };
}
