#nix-repl> nixosConfigurations.DavidTUX.config.snowfallorg.users.david.home.config

{ lib, ... }: with lib.dafitt; {

  dafitt = {
    desktops.hyprland.monitors = [{
      name = "eDP-1";
      width = 1920;
      height = 1080;
      refreshRate = 60;
      workspace = "1";
      primary = true;
    }];

    Development.enableSuite = true;
    Social.enableSuite = true;
  };
}
