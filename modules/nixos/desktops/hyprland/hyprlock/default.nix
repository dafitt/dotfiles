{ options, config, lib, pkgs, ... }:

with lib;
with lib.dafitt;
let
  cfg = config.dafitt.desktops.hyprland.hyprlock;

  # true, if any user has home module `dafitt.desktops.hyprland.hyprlock` enabled
  hyprlock_enabled = builtins.any
    (user: config.snowfallorg.users.${user}.home.config.dafitt.desktops.hyprland.hyprlock.enable)
    (builtins.attrNames config.snowfallorg.users);
in
{
  options.dafitt.desktops.hyprland.hyprlock = with types; {
    allow = mkBoolOpt hyprlock_enabled "Whether or not to allow hyprlock to unlock the screen.";
  };

  config = {
    security.pam.services.hyprlock.text = mkIf cfg.allow "auth include login";
  };
}
