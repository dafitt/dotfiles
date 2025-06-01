{ config, lib, pkgs, inputs, ... }:

with lib;
with lib.dafitt;
let
  cfg = config.dafitt.users.guest;
in
{
  options.dafitt.users.guest = with types; {
    enable = mkEnableOption "user 'guest'";
  };

  config = mkIf cfg.enable {
    users.users."guest" = {
      isNormalUser = true;
      description = "Guest Account";
      password = "guest";
    };
  };
}
