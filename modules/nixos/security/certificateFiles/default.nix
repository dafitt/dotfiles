{ options, config, lib, pkgs, ... }:

with lib;
with lib.dafitt;
let
  cfg = config.dafitt.security.certificateFiles;
in
{
  options.dafitt.security.certificateFiles = with types;{
    enable = mkBoolOpt true "Whether or not to import provided certificate files.";
  };

  config = mkIf cfg.enable {
    security.pki.certificateFiles = [
      ./schallernetz.lan.pem
    ];
  };
}
