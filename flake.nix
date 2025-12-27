{
  description = "Dafitt's desktop flake.";

  #$ flake update [inputs]
  #$ nix flake update [--commit-lock-file]
  #$ nix flake update <input>
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs?ref=nixos-unstable"; # https://github.com/NixOS/nixpkgs

    blueprint.url = "github:numtide/blueprint"; # https://github.com/numtide/blueprint
    blueprint.inputs.nixpkgs.follows = "nixpkgs";

    home-manager.url = "github:nix-community/home-manager"; # https://github.com/nix-community/home-manager
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    nix-darwin.url = "github:LnL7/nix-darwin"; # https://github.com/LnL7/nix-darwin
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";

    betterfox.url = "github:HeitorAugustoLN/betterfox-nix"; # https://github.com/HeitorAugustoLN/betterfox-nix
    betterfox.inputs.nixpkgs.follows = "nixpkgs";
    disko.url = "github:nix-community/disko/latest"; # https://github.com/nix-community/disko
    disko.inputs.nixpkgs.follows = "nixpkgs";
    hypr-darkwindow.url = "github:micha4w/Hypr-DarkWindow"; # https://github.com/micha4w/Hypr-DarkWindow
    impermanence.url = "github:nix-community/impermanence"; # https://github.com/nix-community/impermanence
    nix-flatpak.url = "github:gmodena/nix-flatpak/?ref=latest"; # https://github.com/gmodena/nix-flatpak/tags
    nixGL.url = "github:nix-community/nixGL"; # https://github.com/nix-community/nixGL
    nixGL.inputs.nixpkgs.follows = "nixpkgs";
    nixos-generators.url = "github:nix-community/nixos-generators"; # https://github.com/nix-community/nixos-generators
    nixos-generators.inputs.nixpkgs.follows = "nixpkgs";
    nixos-hardware.url = "github:NixOS/nixos-hardware/master"; # https://github.com/NixOS/nixos-hardware
    noctalia.url = "github:noctalia-dev/noctalia-shell"; # https://github.com/noctalia-dev/noctalia-shell
    noctalia.inputs.nixpkgs.follows = "nixpkgs";
    nur.url = "github:nix-community/NUR"; # https://github.com/nix-community/NUR
    nur.inputs.nixpkgs.follows = "nixpkgs";
    programsdb.url = "github:wamserma/flake-programs-sqlite"; # https://github.com/wamserma/flake-programs-sqlite
    programsdb.inputs.nixpkgs.follows = "nixpkgs";
    stylix.url = "github:danth/stylix"; # https://github.com/danth/stylix
    stylix.inputs.nixpkgs.follows = "nixpkgs";

    # for development; see packages/-git/default.nix
    pyprland.url = "github:hyprland-community/pyprland"; # https://github.com/hyprland-community/pyprland
  };

  #$ nix flake check --keep-going
  #$ nix flake show
  outputs =
    inputs:
    inputs.blueprint {
      inherit inputs;

      nixpkgs.config.allowUnfree = true;

      nixpkgs.overlays = [
        (final: prev: {
          # pyprland = inputs.pyprland.packages.${prev.system}.pyprland;
        })
      ];
    };

  #NOTE uncomment and enter `nix develop` on your first build for faster build time
  #nixConfig = {
  #  extra-substituters = [
  #    "https://hyprland-community.cachix.org"
  #    "https://hyprland.cachix.org"
  #  ];
  #  extra-trusted-public-keys = [
  #    "hyprland-community.cachix.org-1:5dTHY+TjAJjnQs23X+vwMQG4va7j+zmvkTKoYuSXnmE="
  #    "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
  #  ];
  #};
}
