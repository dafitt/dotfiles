{ config, lib, pkgs, ... }: {

  imports = [
    ./programs
  ];

  nixpkgs = {
    #overlays = [ ];
    config = {
      allowUnfree = true;
    };
  };
  xdg.configFile."nixpkgs/config.nix".text = "{ allowUnfree = true; }";
}
