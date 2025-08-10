{ config, lib, ... }:

with lib;
with lib.dafitt;
let
  cfg = config.dafitt.gditors;
in
{
  options.dafitt.gditors = with types;{
    default = mkOption {
      type = nullOr (enum [
        "vscode"
        "zed-editor"
      ]);
      default = null;
      description = "Which terminal editor will be used primarily.";
    };
  };

  config.dafitt.gditors = {
    vscode = mkIf (cfg.default == "vscode") {
      enable = true;
      autostart = config.dafitt.suiteDevelopment.enable;
      configureKeybindings = true;
    };
    zed-editor = mkIf (cfg.default == "zed-editor") {
      enable = true;
      autostart = config.dafitt.suiteDevelopment.enable;
      configureKeybindings = true;
    };
  };
}
