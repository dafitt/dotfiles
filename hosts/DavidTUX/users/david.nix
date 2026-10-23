{ inputs, osConfig, ... }:

#> legacyPackages.x86_64-linux.homeConfigurations."david@DavidTUX".config
{
  home.stateVersion = osConfig.system.stateVersion;

  imports = with inputs.self.homeModules; [
    imports
    user-david

    development
    networking-networkmanager
    social
  ];
}
