{
  description = "Dafitt's desktop flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-23.11";
    unstable.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = { url = "github:nix-community/home-manager/release-23.11"; inputs.nixpkgs.follows = "nixpkgs"; };

    nixos-generators = { url = "github:nix-community/nixos-generators"; inputs.nixpkgs.follows = "nixpkgs"; };

    snowfall-lib = { url = "github:snowfallorg/lib/dev"; inputs.nixpkgs.follows = "nixpkgs"; };
    snowfall-flake = { url = "github:snowfallorg/flake"; inputs.nixpkgs.follows = "nixpkgs"; };


    stylix.url = "github:danth/stylix/release-23.11";

    hyprland.url = "github:hyprwm/hyprland";
    hyprwm-contrib.url = "github:hyprwm/contrib";
    hyprland-plugins = { url = "github:hyprwm/hyprland-plugins"; inputs.hyprland.follows = "hyprland"; };
    hyprkeys = { url = "github:hyprland-community/hyprkeys"; inputs.nixpkgs.follows = "nixpkgs"; };

    programsdb = { url = "github:wamserma/flake-programs-sqlite"; inputs.nixpkgs.follows = "nixpkgs"; };

    nix-flatpak.url = "github:gmodena/nix-flatpak/?ref=v0.3.0";
  };

  # [Snowfall framework](https://snowfall.org/guides/lib/quickstart/)
  outputs = inputs: inputs.snowfall-lib.mkFlake {
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

    overlays = with inputs; [
    ];

    systems.modules.nixos = with inputs; [
    ];

    homes.modules = with inputs; [
      stylix.homeManagerModules.stylix
      nix-flatpak.homeManagerModules.nix-flatpak
    ];

    templates = import ./templates { };
  };
}
