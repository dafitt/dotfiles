{ ... }: {
  #$ nix flake init -t .#<name>
  #$ flake init -t .#<name>

  home = { path = ./home; description = "Template for a new home"; };
  lib = { path = ./lib; description = "Template for a new library"; };
  module = { path = ./module; description = "Template for a new module"; };
  module-home = { path = ./module/home; description = "Template for a new home module"; };
  overlay = { path = ./overlay; description = "Template for a new overlay"; };
  system = { path = ./system; description = "Template for a new system"; };
}
