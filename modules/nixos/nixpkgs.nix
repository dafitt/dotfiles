{ lib, inputs, ... }:
{
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
