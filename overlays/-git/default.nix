# overlay, to follow git repos directly
{ channels, inputs, ... }:

self: super: {
  #PACKAGE = inputs.PACKAGE.packages.${super.system}.PACKAGE;

  #pyprland = inputs.pyprland.packages.${super.system}.pyprland;
}
