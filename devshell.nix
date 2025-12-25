{ pkgs, perSystem }:
#$ nix develop .#default
pkgs.mkShell {
  packages = with pkgs; [
    perSystem.home-manager.default
    git
    nil
    nix
    nix-converter
    nix-prefetch
    nix-prefetch-github
    nixd
    nixpkgs-fmt
  ];

  env = { };

  shellHook = '''';
}
