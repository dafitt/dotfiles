{ config, lib, ... }:

with lib;
with lib.dafitt;
let
  cfg = config.dafitt.clipboardManagers;
in
{
  options.dafitt.clipboardManagers = with types;{
    default = mkOption {
      type = nullOr (enum [
        "cliphist"
        "clipse"
      ]);
      default = null;
      description = "Which file manager will be used primarily.";
    };
  };

  config.dafitt.clipboardManagers = {
    cliphist = mkIf (cfg.default == "cliphist") {
      enable = true;
      configureKeybindings = true;
    };
    clipse = mkIf (cfg.default == "clipse") {
      enable = true;
      configureKeybindings = true;
    };
  };
}
