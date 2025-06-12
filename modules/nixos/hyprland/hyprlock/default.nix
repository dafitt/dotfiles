{ config, lib, pkgs, ... }:

with lib;
with lib.dafitt;
let
  cfg = config.dafitt.hyprland.hyprlock;

  # true, if any user has home module `dafitt.hyprland.hyprlock` enabled
  hyprlock_enabled = any
    (user: config.snowfallorg.users.${user}.home.config.dafitt.hyprland.hyprlock.enable)
    (attrNames config.snowfallorg.users);
in
{
  options.dafitt.hyprland.hyprlock = with types; {
    allow = mkBoolOpt hyprlock_enabled "Whether to allow hyprlock to unlock the screen.";
  };

  config = {
    security.pam.services.hyprlock.text = mkIf cfg.allow "auth include login";
  };
}
