{ config, lib, ... }:

with lib;
with lib.dafitt;
let
  cfg = config.dafitt.filemanagers;
in
{
  options.dafitt.filemanagers = with types;{
    default = mkOption {
      type = nullOr (enum [
        "nautilus"
        "pcmanfm"
        "yazi"
      ]);
      default = null;
      description = "Which file manager will be used primarily.";
    };
  };

  config.dafitt.filemanagers = {
    nautilus = mkIf (cfg.default == "nautilus") {
      enable = true;
      configureKeybindings = true;
    };
    pcmanfm = mkIf (cfg.default == "pcmanfm") {
      enable = true;
      configureKeybindings = true;
    };
    yazi = mkIf (cfg.default == "yazi") {
      enable = true;
      configureKeybindings = true;
    };
  };
}
