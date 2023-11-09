{
  inputs = {

    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs2305.url = "github:nixos/nixpkgs/nixos-23.05";
    nixos-hardware.url = "github:nixos/nixos-hardware"; # Hardware snippets <https://github.com/NixOS/nixos-hardware>

    # TUXEDO drivers <https://nixos.wiki/wiki/TUXEDO_Devices>
    tuxedo-nixos.url = "github:blitz/tuxedo-nixos";
    tuxedo-nixos.inputs.nixpkgs.follows = "nixpkgs2305";

    nix-software-center.url = "github:vlinkz/nix-software-center";

  };

  outputs = { self, nixpkgs, nixpkgs2305, nixos-hardware, tuxedo-nixos, ... }@inputs: {
    # basic configuration: <https://nixos.wiki/wiki/Flakes#Using_nix_flakes_with_NixOS>

    nixosConfigurations = {

      nixos = nixpkgs.lib.nixosSystem {
        # with no configuration, point to the Generic host
        system = "x86_64-linux";
        specialArgs = inputs; # pass all inputs to external configuration files
        modules = [
          ./hosts/Generic.nix
        ];
      };

      DavidDESKTOP = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = inputs;
        modules = [
          ./hosts/DavidDESKTOP.nix
        ];
      };
      DavidLEGION = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = inputs;
        modules = [
          ./hosts/DavidLEGION.nix
        ];
      };
      DavidTUX = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = inputs;
        modules = [
          tuxedo-nixos.nixosModules.default
          ./hosts/DavidTUX.nix
        ];
      };

    };
  };
}
