{ config, lib, ... }:

with lib;
with lib.dafitt;
let
  cfg = config.dafitt.editors;
in
{
  options.dafitt.editors = with types;{
    default = mkOption {
      type = nullOr (enum [
        "micro"
      ]);
      default = null;
      description = "Which terminal editor will be used primarily.";
    };
  };

  config.dafitt.editors = {
    micro = mkIf (cfg.default == "micro") {
      enable = true;
      configureKeybindings = true;
      configureVariables = true;
    };
  };
}
