# install flakes: <https://nix-community.github.io/home-manager/index.html#ch-nix-flakes>

{
  description = "My NixOS configuration";
  inputs = {
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs2311.url = "github:nixos/nixpkgs/nixos-23.11";

    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs2311";

    hyprland = {
      url = "github:hyprwm/hyprland";
      inputs.nixpkgs.follows = "nixpkgs2311";
    };
    hyprwm-contrib = {
      url = "github:hyprwm/contrib";
      inputs.nixpkgs.follows = "nixpkgs2311";
    };

    stylix.url = "github:danth/stylix";

    nixos-hardware.url = "github:nixos/nixos-hardware"; # Hardware snippets <https://github.com/NixOS/nixos-hardware>

    nix-software-center.url = "github:vlinkz/nix-software-center";
  };

  outputs = { self, nixpkgs, home-manager, ... }@inputs: # pass @inputs for futher configuration
    {
      # NixOS configuration entrypoint
      # Available through `nixos-rebuild --flake .#your-hostname`
      nixosConfigurations = {
        nixos = nixpkgs.lib.nixosSystem {
          # with no configuration, point to the Generic host
          system = "x86_64-linux";
          specialArgs = inputs; # pass all inputs to external configuration files
          modules = [ ./nixos/hosts/Generic ];
        };

        DavidDESKTOP = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          specialArgs = inputs;
          modules = [ ./nixos/hosts/DavidDESKTOP ];
        };
        DavidLEGION = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          specialArgs = inputs;
          modules = [ ./nixos/hosts/DavidLEGION ];
        };
        DavidTUX = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          specialArgs = inputs;
          modules = [ ./nixos/hosts/DavidTUX ];
        };
      };

      # Standalone home-manager configuration entrypoint
      # Available through `home-manager --flake .#your-username@your-hostname`
      homeConfigurations = {
        "david" = home-manager.lib.homeManagerConfiguration {
          #pkgs = import nixpkgs { system = "x86_64-linux"; config.allowUnfree = true; };
          pkgs = nixpkgs.legacyPackages.x86_64-linux;
          extraSpecialArgs = inputs;
          modules = [ ./home-manager/david/Template.nix ];
        };
        "david@DavidDESKTOP" = home-manager.lib.homeManagerConfiguration {
          pkgs = nixpkgs.legacyPackages.x86_64-linux;
          extraSpecialArgs = inputs;
          modules = [ ./home-manager/david/DavidDESKTOP.nix ];
        };
        "david@DavidLEGION" = home-manager.lib.homeManagerConfiguration {
          pkgs = nixpkgs.legacyPackages.x86_64-linux;
          extraSpecialArgs = inputs;
          modules = [ ./home-manager/david/DavidLEGION.nix ];
        };
        "david@DavidTUX" = home-manager.lib.homeManagerConfiguration {
          pkgs = nixpkgs.legacyPackages.x86_64-linux;
          extraSpecialArgs = inputs;
          modules = [ ./home-manager/david/DavidTUX.nix ];
        };
      };
    };
}
