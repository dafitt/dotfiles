{ options, config, lib, pkgs, ... }:

with lib;
with lib.dafitt;
let
  cfg = config.dafitt.web.epiphany;
in
{
  options.dafitt.web.epiphany = with types; {
    enable = mkBoolOpt config.dafitt.web.enableSuite "Enable the epiphany web browser";
  };

  config = mkIf cfg.enable {
    # Simple and easy to use web browser
    home.packages = with pkgs; [ epiphany ];
  };
}
