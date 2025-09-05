# overlay, to follow git repos directly
{ channels, inputs, ... }:

self: super: {
  #PACKAGE = inputs.PACKAGE.packages.${prev.system}.PACKAGE;

  #pyprland = inputs.pyprland.packages.${prev.system}.pyprland;
}
