{
  config,
  lib,
  pkgs,
  ...
}:
with lib;
{
  imports = [ ../home/nix.nix ]; # Compatibility with home-manager standalone

  nix.channel.enable = false; # we use flakes instead
}
