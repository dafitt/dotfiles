{ inputs, osConfig, ... }:

#> perSystem.self.homeConfigurations."<user>@<host>"
{
  home.stateVersion = osConfig.system.stateVersion;

  imports =
    with inputs;
    with inputs.self.homeModules;
    [
      imports
      SHARED
      development
      social
    ];
}
