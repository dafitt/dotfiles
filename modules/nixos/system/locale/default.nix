{ options, config, lib, ... }:

with lib;
with lib.custom;
let
  cfg = config.custom.system.locale;
in
{
  options.custom.system.locale = {
    enable = mkBoolOpt true "Whether or not to manage locale settings.";
  };

  config = mkIf cfg.enable {
    i18n = {
      defaultLocale = "en_US.UTF-8";
      supportedLocales = [
        "de_DE.UTF-8/UTF-8"
        "en_US.UTF-8/UTF-8"
      ];
      extraLocaleSettings = {
        LC_ADDRESS = "de_DE.UTF-8";
        LC_COLLATE = "de_DE.UTF-8";
        LC_IDENTIFICATION = "de_DE.UTF-8";
        LC_MEASUREMENT = "de_DE.UTF-8";
        LC_MONETARY = "de_DE.UTF-8";
        LC_NAME = "de_DE.UTF-8";
        LC_NUMERIC = "de_DE.UTF-8";
        LC_PAPER = "de_DE.UTF-8";
        LC_TELEPHONE = "de_DE.UTF-8";
        LC_TIME = "de_DE.UTF-8";
      };
    };

    console.keyMap = mkDefault "de-latin1-nodeadkeys";
    services.xserver = mkDefault { layout = "de"; xkbVariant = "nodeadkeys"; };
  };
}
