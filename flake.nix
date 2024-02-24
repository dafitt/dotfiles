# install flakes: <https://nix-community.github.io/home-manager/index.html#ch-nix-flakes>

{
  description = "Dafitt's desktop flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-23.11";
    unstable.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager/release-23.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    snowfall-lib = {
      url = "github:snowfallorg/lib";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    stylix.url = "github:danth/stylix/release-23.11";

    agenix.url = "github:ryantm/agenix";

    hyprland.url = "github:hyprwm/hyprland";
    hyprwm-contrib.url = "github:hyprwm/contrib";
    hyprland-plugins = {
      url = "github:hyprwm/hyprland-plugins";
      inputs.hyprland.follows = "hyprland";
    };

    tuxedo-nixos.url = "github:blitz/tuxedo-nixos";
  };

  # [Snowfall framework](https://snowfall.org/guides/lib/quickstart/)
  outputs = inputs:
    let
      path = {
        # TODO make obsolete
        rootDir = ./.;
        nixosDir = ./nixos;
        pkgsDir = ./pkgs;
      };
    in
    inputs.snowfall-lib.mkFlake
      {
        inherit inputs;
        src = ./.;

        snowfall = {
          namespace = "custom";
          meta = {
            name = "dafitt-desktop-flake";
            title = "Dafitt's desktop flake";
          };
        };

        channels-config = {
          allowUnfree = true;
        };

        homes.users."david@DavidDESKTOP".specialArgs = { inherit path; };
        homes.users."david@DavidLEGION".specialArgs = { inherit path; };
        homes.users."david@DavidTUX".specialArgs = { inherit path; };

        overlays = with inputs; [ ];

        systems.modules.nixos = with inputs; [ ];
        systems.hosts."DavidDESKTOP".specialArgs = { inherit path; };
        systems.hosts."DavidLEGION".specialArgs = { inherit path; };
        systems.hosts."DavidTUX".specialArgs = { inherit path; };

        templates = import ./templates { };
      };
}
