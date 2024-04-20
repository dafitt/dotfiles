{ pkgs, inputs, ... }:

#$ flake dev
#$ nix develop
pkgs.mkShell {
  nativeBuildInputs = with pkgs; with inputs; [
    git
    nix
    home-manager.packages.${system}.default
    snowfall-flake.packages.${system}.default
  ];
}
