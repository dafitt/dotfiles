{
  config,
  lib,
  pkgs,
  ...
}:

with lib;
with lib.dafitt;
let
  cfg = config.dafitt.appimage;
in
{
  options.dafitt.appimage = with types; {
    enable = mkEnableOption "appimage support";
  };

  config = mkIf cfg.enable {
    # https://wiki.nixos.org/wiki/Appimage
    programs.appimage = {
      enable = true;
      binfmt = true;
    };
  };
}
