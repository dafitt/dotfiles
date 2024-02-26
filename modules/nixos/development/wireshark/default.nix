{ options, config, lib, pkgs, ... }:

with lib;
with lib.custom;
let
  cfg = config.custom.development.wireshark;
in
{
  options.custom.development.wireshark = with types; {
    enable = mkBoolOpt false "Enable wireshark, a network protocol analyzer";
  };

  config = mkIf cfg.enable {
    programs.wireshark = {
      enable = true;
    };
  };
}
