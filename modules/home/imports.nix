{ pkgs, inputs, ... }:
{
  #meta.doc = builtins.toFile "doc.md" ''
  #  Workaround for a known issue [NixOS/nixpkgs#340361](https://github.com/NixOS/nixpkgs/issues/340361)
  #  not beeing able to import multiple imports of the same NixOS module.
  #'';

  imports = with inputs; [
    niri.homeModules.niri
    noctalia.homeModules.default
  ];

  programs.niri.package = pkgs.niri; # follow nixpkgs
}
