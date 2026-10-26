{
  inputs,
  config,
  osConfig,
  ...
}:

#> legacyPackages.x86_64-linux.homeConfigurations."david@DavidTUX".config
{
  home.stateVersion = osConfig.system.stateVersion;
  # default value changes since stateVersion
  programs.firefox.configPath = "${config.xdg.configHome}/mozilla/firefox";
  programs.nushell.loadSessionVariables = true;

  imports = with inputs.self.homeModules; [
    imports
    user-david

    development
    networking-networkmanager
    social
  ];
}
