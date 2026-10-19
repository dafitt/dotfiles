{ config, inputs, ... }:

#> perSystem.self.homeConfigurations."david@DavidLEGION"
{
  home.stateVersion = "23.11";
  # default behavior changes
  programs.firefox.configPath = "${config.xdg.configHome}/mozilla/firefox";

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
