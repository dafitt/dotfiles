{ config, lib, ... }:

with lib;
with lib.dafitt;
let
  cfg = config.dafitt.terminals;
in
{
  options.dafitt.terminals = with types; {
    default = mkOption {
      type = nullOr (enum [
        "kitty"
      ]);
      default = "kitty";
      description = "Which terminal emulator will be used primarily.";
    };
  };

  config.dafitt.terminals = {
    kitty = mkIf (cfg.default == "kitty") {
      enable = true;
      configureKeybindings = true;
      configureVariables = true;
    };
  };
}
