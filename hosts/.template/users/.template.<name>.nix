{ inputs, ... }:

#> legacyPackages.x86_64-linux.homeConfigurations."<user>@<host>".config
{
  home.stateVersion = "25.11";

  imports =
    with inputs;
    with inputs.self.homeModules;
    [
      imports
    ];
}
