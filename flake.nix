{
  #$ flake update [inputs]
  #$ nix flake update [--commit-lock-file]
  #$ nix flake lock --update-input [input]
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable"; # https://github.com/NixOS/nixpkgs
    nur.url = "github:nix-community/NUR"; # https://github.com/nix-community/NUR

    home-manager = { url = "github:nix-community/home-manager"; inputs.nixpkgs.follows = "nixpkgs"; }; # https://github.com/nix-community/home-manager
    nixos-generators = { url = "github:nix-community/nixos-generators"; inputs.nixpkgs.follows = "nixpkgs"; }; # https://github.com/nix-community/nixos-generators

    snowfall-lib = { url = "github:snowfallorg/lib/dev"; inputs.nixpkgs.follows = "nixpkgs"; }; # https://github.com/snowfallorg/lib
    snowfall-flake = { url = "github:snowfallorg/flake"; inputs.nixpkgs.follows = "nixpkgs"; }; # https://github.com/snowfallorg/flake

    stylix.url = "github:danth/stylix"; # https://github.com/danth/stylix

    #NOTE We use the hyprland option from nixpkgs but we need this input for the plugins, which want to follow hyprland.
    #NOTE Update the version in case hyprland updates on nixpkgs!
    hyprland = { url = "github:hyprwm/Hyprland/tags/v0.32.3"; inputs.nixpkgs.follows = "nixpkgs"; }; # https://github.com/hyprwm/Hyprland
    hyprland-plugins = { url = "github:hyprwm/hyprland-plugins"; inputs.hyprland.follows = "hyprland"; }; # https://github.com/hyprwm/hyprland-plugins
    #TODO 24.05: hypr-darkwindow = { url = "github:micha4w/Hypr-DarkWindow/tags/v0.36.0"; inputs.hyprland.follows = "hyprland"; }; # https://github.com/micha4w/Hypr-DarkWindow
    #TODO 24.05: hyprspace = { url = "github:KZDKM/Hyprspace"; inputs.hyprland.follows = "hyprland"; }; # https://github.com/KZDKM/Hyprspace

    hypridle = { url = "github:hyprwm/hypridle"; inputs.nixpkgs.follows = "nixpkgs"; }; # https://github.com/hyprwm/hypridle
    hyprlock = { url = "github:hyprwm/hyprlock"; inputs.nixpkgs.follows = "nixpkgs"; }; # https://github.com/hyprwm/hyprlock
    hyprpaper = { url = "github:hyprwm/hyprpaper"; inputs.nixpkgs.follows = "nixpkgs"; }; # https://github.com/hyprwm/hyprpaper

    programsdb = { url = "github:wamserma/flake-programs-sqlite"; inputs.nixpkgs.follows = "nixpkgs"; }; # https://github.com/wamserma/flake-programs-sqlite

    nix-flatpak.url = "github:gmodena/nix-flatpak/?ref=v0.4.1"; # https://github.com/gmodena/nix-flatpak
  };

  # [Snowfall framework](https://snowfall.org/guides/lib/quickstart/)
  #$ nix flake check --keep-going
  #$ nix flake show
  #$ nix fmt [./folder] [./file.nix]
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
      stylix.nixosModules.stylix
    ];

    homes.modules = with inputs; [
      stylix.homeManagerModules.stylix
      hyprlock.homeManagerModules.default
      hyprpaper.homeManagerModules.default
      nix-flatpak.homeManagerModules.nix-flatpak
    ];

    templates = import ./templates { };

    # [Generic outputs](https://snowfall.org/guides/lib/generic/)
    outputs-builder = channels: {
      formatter = channels.nixpkgs.nixpkgs-fmt; # [nix fmt](https://nixos.org/manual/nix/stable/command-ref/new-cli/nix3-fmt.html)
    };
  };

  description = "Dafitt's desktop flake";
}
