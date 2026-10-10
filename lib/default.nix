{ inputs, ... }:

with inputs.nixpkgs.lib;
{
  # Use with home-manager-mutableFiles.nix
  #
  # e.g.
  # ```
  # { flake, inputs, ... }: {
  #   imports = [ inputs.self.homeModules.home-manager-mutableFiles ];
  #
  #   xdg.configFile = flake.lib.mkMutableFiles [
  #     "foo/config.toml"
  #     "bar/settings.ini"
  #   ];
  # }
  # ```
  mkMutableFiles =
    files:
    genAttrs files (_: {
      force = true;
      mutable = true;
    });
}
