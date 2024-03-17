{ pkgs, inputs, ... }:
pkgs.mkShell {
  nativeBuildInputs = with pkgs; with inputs; [
    snowfall-flake.packages.${system}.default
    home-manager.packages.${system}.default
    nix-prefetch-git

    # Formatting
    treefmt
    alejandra
    python310Packages.mdformat
    shfmt
  ];
}