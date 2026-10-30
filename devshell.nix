{ pkgs, perSystem }:
#$ nix develop .#default
pkgs.mkShell {
  packages = with pkgs; [
    git
    jujutsu
    micro
    nil
    nix
    nix-converter
    nix-prefetch
    nix-prefetch-github
    nixd
    nixpkgs-fmt
    perSystem.home-manager.default
  ];

  env = { };

  shellHook = '''';
}
