{ config, inputs, ... }:

#> legacyPackages.x86_64-linux.homeConfigurations."david@DavidLEGION".config
{
  home.stateVersion = "23.11";
  # default value changes since stateVersion
  programs.firefox.configPath = "${config.xdg.configHome}/mozilla/firefox";
  programs.nushell.loadSessionVariables = true;

  imports = with inputs.self.homeModules; [
    imports
    user-david

    development
    fileManager-yazi
    networking-networkmanager
    office
    social
    wluma
  ];
}
