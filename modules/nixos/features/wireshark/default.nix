{ options, config, lib, pkgs, ... }:

with lib;
with lib.custom;
let
  cfg = config.custom.features.wireshark;
in
{
  options.custom.features.wireshark = with types; {
    enable = mkBoolOpt false "Enable wireshark, a network protocol analyzer";
  };

  config = mkIf cfg.enable {
    programs.wireshark = {
      enable = true;
    };
  };
}
