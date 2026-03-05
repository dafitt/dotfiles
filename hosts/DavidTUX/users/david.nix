{ inputs, osConfig, ... }:

#> perSystem.self.homeConfigurations."<user>@<host>"
{
  home.stateVersion = osConfig.system.stateVersion;

  imports = with inputs.self.homeModules; [
    user-david

    development
    imports
    social
  ];
}
