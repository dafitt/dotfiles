{ inputs, ... }:
#> legacyPackages.x86_64-linux.homeConfigurations."sdc2tt@TT-WCN00692".config
#$ home-manager --flake .#sdc2tt@TT-WCN00692 switch
{
  home.stateVersion = "25.11";

  imports = with inputs.self.homeModules; [
    imports
    user-sdc2tt
  ];
}
