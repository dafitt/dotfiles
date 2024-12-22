{
  #$ flake update [inputs]
  #$ nix flake update [--commit-lock-file]
  #$ nix flake update <input>
  inputs = {
    home-manager = { url = "github:nix-community/home-manager"; inputs.nixpkgs.follows = "nixpkgs"; }; # https://github.com/nix-community/home-manager
    hypr-darkwindow = { url = "github:micha4w/Hypr-DarkWindow"; }; # https://github.com/micha4w/Hypr-DarkWindow
    hyprspace = { url = "github:KZDKM/Hyprspace"; }; # https://github.com/KZDKM/Hyprspace
    hyprsplit = { url = "github:shezdy/hyprsplit"; }; # https://github.com/shezdy/hyprsplit
    nix-flatpak.url = "github:gmodena/nix-flatpak/v0.5.2"; # https://github.com/gmodena/nix-flatpak/tags
    nixos-generators = { url = "github:nix-community/nixos-generators"; inputs.nixpkgs.follows = "nixpkgs"; }; # https://github.com/nix-community/nixos-generators
    nixos-hardware.url = "github:nixos/nixos-hardware/master"; # https://github.com/NixOS/nixos-hardware
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable"; # https://github.com/NixOS/nixpkgs
    nur.url = "github:nix-community/NUR"; # https://github.com/nix-community/NUR
    programsdb = { url = "github:wamserma/flake-programs-sqlite"; inputs.nixpkgs.follows = "nixpkgs"; }; # https://github.com/wamserma/flake-programs-sqlite
    snowfall-flake = { url = "github:snowfallorg/flake"; inputs.nixpkgs.follows = "nixpkgs"; }; # https://github.com/snowfallorg/flake
    snowfall-lib = { url = "github:snowfallorg/lib/dev"; inputs.nixpkgs.follows = "nixpkgs"; }; # https://github.com/snowfallorg/lib
    stylix.url = "github:danth/stylix"; # https://github.com/danth/stylix

    # for development; see overlays/-git/default.nix
    pyprland.url = "github:hyprland-community/pyprland"; # https://github.com/hyprland-community/pyprland
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
      nur.overlays.default
    ];

    systems.modules.nixos = with inputs; [
      stylix.nixosModules.stylix
    ];

    homes.modules = with inputs; [
      stylix.homeManagerModules.stylix
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
