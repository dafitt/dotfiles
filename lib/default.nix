{ inputs, ... }:

with inputs.nixpkgs.lib;
{
  # Use with home-manager-mutableFiles.nix
  mkMutableFiles =
    files:
    genAttrs files (_: {
      force = true;
      mutable = true;
    });
}
