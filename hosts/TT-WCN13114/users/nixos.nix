{ inputs, ... }:

#> legacyPackages.x86_64-linux.homeConfigurations."nixos@TT-WCN13114".config
{
  home.stateVersion = "26.05";

  imports =
    with inputs;
    with inputs.self.homeModules;
    [
      imports
    ];
}
