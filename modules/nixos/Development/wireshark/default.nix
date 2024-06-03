{ options, config, lib, pkgs, ... }:

with lib;
with lib.dafitt;
let
  cfg = config.dafitt.Development.wireshark;
in
{
  options.dafitt.Development.wireshark = with types; {
    enable = mkBoolOpt false "Enable wireshark, a network protocol analyzer.";
  };

  config = mkIf cfg.enable {
    programs.wireshark = {
      enable = true;
    };
  };
}
