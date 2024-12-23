#nix-repl> nixosConfigurations.DavidTUX.config.snowfallorg.users.david.home.config

{ config, lib, pkgs, inputs, ... }:

with lib;
with lib.dafitt; {
  imports = with inputs; [
    ../../user-configurations/david.nix
  ];

  dafitt = {
    desktops.hyprland.monitors = [{
      name = "eDP-1";
      width = 1920;
      height = 1080;
      refreshRate = 60;
      workspace = "1";
      primary = true;
    }];

    suiteDevelopment.enable = true;
    suiteSocial.enable = true;
  };
}
