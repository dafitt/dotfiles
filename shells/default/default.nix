{ pkgs, inputs, ... }:

pkgs.mkShell {
  #$ flake dev
  #$ nix develop

  nativeBuildInputs = with pkgs; with inputs; [
    snowfall-flake.packages.${system}.default
    home-manager.packages.${system}.default
    nix-prefetch-git

    # Formatting
    treefmt
    nixpkgs-fmt
    python310Packages.mdformat
    shfmt
  ];
}
