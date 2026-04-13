{ inputs, osConfig, ... }:

#> perSystem.self.homeConfigurations."<user>@<host>"
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
