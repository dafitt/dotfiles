# install flakes: <https://nix-community.github.io/home-manager/index.html#ch-nix-flakes>

{
  description = "My NixOS configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-23.11";
    unstable.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager/release-23.11";
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

  outputs = { nixpkgs, home-manager, ... }@inputs: # pass @inputs for futher configuration
    let
      path = {
        rootDir = ./.;
        nixosDir = ./nixos;
        secretsDir = ./secrets;
        pkgsDir = ./pkgs;
      };
    in
    {
      # NixOS configuration entrypoint
      # Available through `nixos-rebuild --flake .#your-hostname`
      nixosConfigurations = {

        "nixos" = nixpkgs.lib.nixosSystem {
          # with no configuration, point to the Generic host
          system = "x86_64-linux";
          specialArgs = { inherit inputs path; }; # pass all inputs to external configuration files
          modules = [ ./nixos/hosts/Generic ];
        };
        "DavidDESKTOP" = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          specialArgs = { inherit inputs path; };
          modules = [ ./nixos/hosts/DavidDESKTOP ];
        };
        "DavidLEGION" = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          specialArgs = { inherit inputs path; };
          modules = [ ./nixos/hosts/DavidLEGION ];
        };
        "DavidTUX" = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          specialArgs = { inherit inputs path; };
          modules = [ ./nixos/hosts/DavidTUX ];
        };
      };

      # Standalone home-manager configuration entrypoint
      # Available through `home-manager --flake .#your-username@your-hostname`
      homeConfigurations = {

        "david@DavidDESKTOP" = home-manager.lib.homeManagerConfiguration {
          pkgs = nixpkgs.legacyPackages.x86_64-linux;
          extraSpecialArgs = { inherit inputs path; };
          modules = [ ./home-manager/david/DavidDESKTOP.nix ];
        };
        "david@DavidLEGION" = home-manager.lib.homeManagerConfiguration {
          pkgs = nixpkgs.legacyPackages.x86_64-linux;
          extraSpecialArgs = { inherit inputs path; };
          modules = [ ./home-manager/david/DavidLEGION.nix ];
        };
        "david@DavidTUX" = home-manager.lib.homeManagerConfiguration {
          pkgs = nixpkgs.legacyPackages.x86_64-linux;
          extraSpecialArgs = { inherit inputs path; };
          modules = [ ./home-manager/david/DavidTUX.nix ];
        };
      };
    };
}
