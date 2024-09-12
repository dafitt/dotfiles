{ config, lib, ... }:

with lib;
with lib.dafitt;
let
  cfg = config.dafitt.passwordManager;
in
{
  options.dafitt.passwordManager = with types;{
    default = mkOpt (nullOr (enum [ "_1password" "bitwarden" ])) "bitwarden" "Which application launcher is to be used primarily";
  };
}
