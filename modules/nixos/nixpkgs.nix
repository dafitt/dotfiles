{ lib, inputs, ... }:
{
  #meta.doc = builtins.toFile "doc.md" ''
  #  Configures Nixpkgs within your flake.

  #  Workaround for <https://github.com/numtide/blueprint/issues/115>.
  #'';

  # nixpkgs.config.allowUnfree = true;
  nixpkgs.config.allowUnfreePredicate =
    pkg:
    builtins.elem (lib.getName pkg) [
      "steam"
      "steam-unwrapped"
      "yEd"
    ];

  nixpkgs.overlays = [
    (final: prev: {
      # pyprland = inputs.pyprland.packages.${prev.system}.pyprland;
    })
  ];
}
