# overlay, to follow packages from upstream directly
{ inputs, ... }:

final: prev: {
  pyprland = inputs.pyprland.packages.${prev.system}.pyprland;
}
