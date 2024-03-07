{ config, lib, options, pkgs, ... }:

with lib;
with lib.custom;
let
  cfg = config.custom.web.epiphany;
in
{
  options.custom.web.epiphany = with types; {
    enable = mkBoolOpt false "Enable the epiphany web browser";
  };

  config = mkIf cfg.enable {
    # Simple and easy to use web browser
    home.packages = with pkgs; [ epiphany ];
  };
}
