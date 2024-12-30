{ config, lib, ... }:

with lib;
with lib.dafitt;
let
  cfg = config.dafitt.passwordManager;
in
{
  options.dafitt.passwordManager = with types;{
    default = mkOption {
      type = nullOr (enum [ "_1password" "bitwarden" ]);
      default = null;
      description = "Which password manager will be used primarily.";
    };
  };
}
