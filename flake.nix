{
  #$ flake update [inputs]
  #$ nix flake update [--commit-lock-file]
  #$ nix flake lock --update-input <input>
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable"; # https://github.com/NixOS/nixpkgs
    nur.url = "github:nix-community/NUR"; # https://github.com/nix-community/NUR

    home-manager = { url = "github:nix-community/home-manager"; inputs.nixpkgs.follows = "nixpkgs"; }; # https://github.com/nix-community/home-manager
    nixos-generators = { url = "github:nix-community/nixos-generators"; inputs.nixpkgs.follows = "nixpkgs"; }; # https://github.com/nix-community/nixos-generators
    nixos-hardware.url = "github:nixos/nixos-hardware/master"; # https://github.com/NixOS/nixos-hardware

    snowfall-lib = { url = "github:snowfallorg/lib/dev"; inputs.nixpkgs.follows = "nixpkgs"; }; # https://github.com/snowfallorg/lib
    snowfall-flake = { url = "github:snowfallorg/flake"; inputs.nixpkgs.follows = "nixpkgs"; }; # https://github.com/snowfallorg/flake

    stylix.url = "github:danth/stylix"; # https://github.com/danth/stylix

    hyprland = { url = "github:hyprwm/Hyprland/tags/v0.40.0"; inputs.nixpkgs.follows = "nixpkgs"; }; # https://github.com/hyprwm/Hyprland/tags
    hyprland-plugins = { url = "github:hyprwm/hyprland-plugins"; inputs.hyprland.follows = "hyprland"; }; # https://github.com/hyprwm/hyprland-plugins
    hypr-darkwindow = { url = "github:micha4w/Hypr-DarkWindow/tags/v0.40.0"; inputs.hyprland.follows = "hyprland"; }; # https://github.com/micha4w/Hypr-DarkWindow/tags
    hyprspace = { url = "github:KZDKM/Hyprspace"; inputs.hyprland.follows = "hyprland"; }; # https://github.com/KZDKM/Hyprspace
    hyprsplit = { url = "github:shezdy/hyprsplit/tags/v0.40.0"; inputs.hyprland.follows = "hyprland"; }; # https://github.com/shezdy/hyprsplit/tags

    hypridle = { url = "github:hyprwm/hypridle"; inputs.nixpkgs.follows = "nixpkgs"; }; # https://github.com/hyprwm/hypridle
    hyprlock = { url = "github:hyprwm/hyprlock"; inputs.nixpkgs.follows = "nixpkgs"; }; # https://github.com/hyprwm/hyprlock
    hyprpaper = { url = "github:hyprwm/hyprpaper"; inputs.nixpkgs.follows = "nixpkgs"; }; # https://github.com/hyprwm/hyprpaper

    programsdb = { url = "github:wamserma/flake-programs-sqlite"; inputs.nixpkgs.follows = "nixpkgs"; }; # https://github.com/wamserma/flake-programs-sqlite

    nix-flatpak.url = "github:gmodena/nix-flatpak/tags/v0.4.1"; # https://github.com/gmodena/nix-flatpak/tags

    # for development; see overlays/-git/default.nix
    #$ nix flake lock --update-input <input>
    pyprland.url = "github:hyprland-community/pyprland";
  };

  #NOTE uncomment and enter `nix develop` on your first build for faster build time
  #nixConfig = {
  #  extra-substituters = [
  #    "https://hyprland.cachix.org"
  #    "https://hyprland-community.cachix.org"
  #  ];
  #  extra-trusted-public-keys = [
  #    "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
  #    "hyprland-community.cachix.org-1:5dTHY+TjAJjnQs23X+vwMQG4va7j+zmvkTKoYuSXnmE="
  #  ];
  #};


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
      hyprland.nixosModules.default
    ];

    homes.modules = with inputs; [
      stylix.homeManagerModules.stylix
      hyprland.homeManagerModules.default
      nix-flatpak.homeManagerModules.nix-flatpak
    ];

    templates = import ./templates { };

    # [Generic outputs](https://snowfall.org/guides/lib/generic/)
    outputs-builder = channels: {
      formatter = channels.nixpkgs.nixpkgs-fmt; # [nix fmt](https://nixos.org/manual/nix/stable/command-ref/new-cli/nix3-fmt.html)
    };
  };

  description = "Dafitt's desktop flake.";
}
