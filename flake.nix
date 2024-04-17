{
  #$ flake update [inputs]
  #$ nix flake update [--commit-lock-file]
  #$ nix flake lock --update-input [input]
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-23.11"; # https://github.com/NixOS/nixpkgs
    unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    nur.url = "github:nix-community/NUR"; # https://github.com/nix-community/NUR

    home-manager = { url = "github:nix-community/home-manager/release-23.11"; inputs.nixpkgs.follows = "nixpkgs"; }; # https://github.com/nix-community/home-manager
    nixos-generators = { url = "github:nix-community/nixos-generators"; inputs.nixpkgs.follows = "nixpkgs"; }; # https://github.com/nix-community/nixos-generators

    snowfall-lib = { url = "github:snowfallorg/lib/dev"; inputs.nixpkgs.follows = "nixpkgs"; }; # https://github.com/snowfallorg/lib
    snowfall-flake = { url = "github:snowfallorg/flake"; inputs.nixpkgs.follows = "nixpkgs"; }; # https://github.com/snowfallorg/flake

    stylix.url = "github:danth/stylix/release-23.11"; # https://github.com/danth/stylix

    hypridle = { url = "github:hyprwm/hypridle"; inputs.nixpkgs.follows = "nixpkgs"; }; # https://github.com/hyprwm/hypridle
    hyprlock = { url = "github:hyprwm/hyprlock"; inputs.nixpkgs.follows = "nixpkgs"; }; # https://github.com/hyprwm/hyprlock
    hyprpaper = { url = "github:hyprwm/hyprpaper"; inputs.nixpkgs.follows = "nixpkgs"; }; # https://github.com/hyprwm/hyprpaper

    programsdb = { url = "github:wamserma/flake-programs-sqlite"; inputs.nixpkgs.follows = "nixpkgs"; }; # https://github.com/wamserma/flake-programs-sqlite

    nix-flatpak.url = "github:gmodena/nix-flatpak/?ref=v0.4.1"; # https://github.com/gmodena/nix-flatpak
  };

  # [Snowfall framework](https://snowfall.org/guides/lib/quickstart/)
  #$ nix flake check --keep-going
  #$ nix flake show
  outputs = inputs: inputs.snowfall-lib.mkFlake {
    inherit inputs;
    src = ./.;

    snowfall = {
      namespace = "dafitt";
      meta = {
        name = "dafitt-desktop-flake";
        title = "Dafitt's desktop flake";
      };
    };

    channels-config = {
      allowUnfree = true;
    };

    overlays = with inputs; [
      nur.overlay
    ];

    systems.modules.nixos = with inputs; [
    ];

    homes.modules = with inputs; [
      stylix.homeManagerModules.stylix
      hypridle.homeManagerModules.default
      hyprlock.homeManagerModules.default
      hyprpaper.homeManagerModules.default
      nix-flatpak.homeManagerModules.nix-flatpak
    ];

    templates = import ./templates { };
  };

  description = "Dafitt's desktop flake";
}
