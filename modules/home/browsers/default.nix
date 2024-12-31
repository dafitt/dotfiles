{ options, config, lib, pkgs, osConfig ? { }, ... }:

with lib;
with lib.dafitt;
let
  cfg = config.dafitt.browsers;
in
{
  options.dafitt.browsers = with types; {
    default = mkOption {
      type = nullOr (enum [
        "epiphany"
        "firefox"
        "librewolf"
      ]);
      default = null;
      description = "Which web browser will be used primarily.";
    };
  };

  config.dafitt.browsers = {
    epiphany = mkIf (cfg.default == "epiphany") {
      enable = true;
      configureKeybindings = true;
    };
    firefox = mkIf (cfg.default == "firefox") {
      enable = true;
      configureKeybindings = true;
    };
    librewolf = mkIf (cfg.default == "librewolf") {
      enable = true;
      configureKeybindings = true;
    };
  };
}
