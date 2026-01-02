{ inputs, osConfig, ... }:

{
  home.stateVersion = osConfig.system.stateVersion;

  imports =
    with inputs;
    with inputs.self.homeModules;
    [
      SHARED
      development
      web
    ];
}
