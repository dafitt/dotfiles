{ pkgs, inputs, ... }:

#$ nix develop .#default
pkgs.mkShell {
  nativeBuildInputs =
    with pkgs;
    with inputs;
    [
      git
      home-manager.packages.${system}.default
      nil # nix language server
      nix
      nix-converter # nix <-> json/yaml/toml converter
      nix-prefetch # Prefetch any fetcher function call, e.g. package sources
      nix-prefetch-github # Prefetch sources from github
      nixd # nix language server
      nixpkgs-fmt # nix formatter
    ];
}
