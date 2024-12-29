{ options, config, lib, pkgs, osConfig ? { }, ... }:

with lib;
with lib.dafitt;
let
  cfg = config.dafitt;
in
{
  options.dafitt = with types; {
    enable = mkBoolOpt (osConfig.dafitt.enable or false) "Whether to enable dafitt defaults.";
  };

  config = mkIf cfg.enable {
    dafitt = {
      browsers.default = "firefox";
      btop.enable = true;
      editors.default = "micro";
      eog.enable = true;
      fastfetch.enable = true;
      file-roller.enable = true;
      filemanagers.default = "nautilus";
      flatpak.enable = true;
      gedit.enable = true;
      imv.enable = true;
      launchers.default = "fuzzel";
      mpv.enable = true;
      pavucontrol.enable = true;
      personalEnvironment.enable = true;
      starship.enable = true;
      syncthing.enable = true;
      systemd.enable = true;
      terminals.default = "kitty";
      xdg.enable = true;
    };
  };
}
