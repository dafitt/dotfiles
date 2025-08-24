{
  #$ nix flake show templates
  #$ nix flake init -t .#<name>
  home = {
    path = ./homes;
    description = "Template for a new home.";
  };
  lib = {
    path = ./lib/lib;
    description = "Template for a new library.";
  };
  nixos-module = {
    path = ./modules-nixos;
    description = "Template for a new nixos-module.";
  };
  home-module = {
    path = ./modules-home;
    description = "Template for a new home-module.";
  };
  overlay = {
    path = ./overlays;
    description = "Template for a new overlay.";
  };
  system = {
    path = ./systems;
    description = "Template for a new system.";
  };
}
