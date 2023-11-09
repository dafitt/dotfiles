# install flakes: <https://nix-community.github.io/home-manager/index.html#ch-nix-flakes>

{
  inputs = {
    # Specify sources
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    stylix.url = "github:danth/stylix";
  };

  outputs = { nixpkgs, home-manager, stylix, ... }@inputs: # allow @inputs in home.nix
    {
      homeConfigurations."david" = home-manager.lib.homeManagerConfiguration {
        pkgs = import nixpkgs { system = "x86_64-linux"; config.allowUnfree = true; };

        #extraSpecialArgs = { inherit inputs; }; # expose "inputs" to home-manager

        modules = [
          stylix.homeManagerModules.stylix
          ./home.nix
        ];

      };
    };
}
