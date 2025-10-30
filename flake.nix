{
  #$ flake update [inputs]
  #$ nix flake update [--commit-lock-file]
  #$ nix flake update <input>
  inputs = {
    # https://github.com/HeitorAugustoLN/betterfox-nix
    betterfox = {
      url = "github:HeitorAugustoLN/betterfox-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # https://github.com/nix-community/disko
    disko = {
      url = "github:nix-community/disko/latest";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # https://github.com/nix-community/home-manager
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # https://github.com/micha4w/Hypr-DarkWindow
    hypr-darkwindow = {
      url = "github:micha4w/Hypr-DarkWindow";
    };
    # https://github.com/nix-community/impermanence
    impermanence = {
      url = "github:nix-community/impermanence";
    };
    # https://github.com/gmodena/nix-flatpak/tags
    nix-flatpak = {
      url = "github:gmodena/nix-flatpak/v0.5.2";
    };
    # https://github.com/nix-community/nixGL
    nixGL = {
      url = "github:nix-community/nixGL";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # https://github.com/nix-community/nixos-generators
    nixos-generators = {
      url = "github:nix-community/nixos-generators";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # https://github.com/NixOS/nixos-hardware
    nixos-hardware = {
      url = "github:NixOS/nixos-hardware/master";
    };
    # https://github.com/NixOS/nixpkgs
    nixpkgs = {
      url = "github:NixOS/nixpkgs/nixos-unstable";
    };
    # https://github.com/nix-community/NUR
    nur = {
      url = "github:nix-community/NUR";
    };
    # https://github.com/wamserma/flake-programs-sqlite
    programsdb = {
      url = "github:wamserma/flake-programs-sqlite";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # https://github.com/snowfallorg/lib
    snowfall-lib = {
      url = "github:snowfallorg/lib";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # https://github.com/danth/stylix
    stylix = {
      url = "github:danth/stylix";
    };

    # for development; see overlays/-git/default.nix
    pyprland.url = "github:hyprland-community/pyprland"; # https://github.com/hyprland-community/pyprland
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

  # [Snowfall framework](https://snowfall.org/guides/lib/quickstart/)
  #$ nix flake check --keep-going
  #$ nix flake show
  #$ nix fmt [./folder] [./file.nix]
  outputs =
    inputs:
    inputs.snowfall-lib.mkFlake {
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
        nixGL.overlays.default
      ];

      systems.modules.nixos = with inputs; [
        disko.nixosModules.disko
        impermanence.nixosModules.impermanence
        stylix.nixosModules.stylix
      ];

      homes.modules = with inputs; [
        betterfox.homeModules.betterfox
        impermanence.homeManagerModules.impermanence
        nix-flatpak.homeManagerModules.nix-flatpak
        stylix.homeModules.stylix
      ];

      # [Generic outputs](https://snowfall.org/guides/lib/generic/)
      outputs-builder = channels: {
        formatter = channels.nixpkgs.nixfmt-tree; # [nix fmt](https://nixos.org/manual/nix/stable/command-ref/new-cli/nix3-fmt.html)
      };
    };

  description = "Dafitt's desktop flake.";
}
