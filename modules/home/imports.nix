# This module is a workarount to https://github.com/NixOS/nixpkgs/issues/340361
{ inputs, ... }:
{
  imports = with inputs; [
    niri.homeModules.niri
    noctalia.homeModules.default
  ];
}
