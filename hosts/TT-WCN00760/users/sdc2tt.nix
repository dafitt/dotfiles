{ inputs, ... }:
#> legacyPackages.x86_64-linux.homeConfigurations."sdc2tt@TT-WCN00760".config
#$ home-manager --flake .#sdc2tt@TT-WCN00760 switch
{
  home.stateVersion = "26.05";

  imports = with inputs.self.homeModules; [
    imports
    user-sdc2tt
  ];
}
