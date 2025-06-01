{ pkgs, inputs, ... }:

#$ nix develop .#default
pkgs.mkShell {
  nativeBuildInputs = with pkgs; with inputs; [
    git
    nix
    home-manager.packages.${system}.default
  ];
}
