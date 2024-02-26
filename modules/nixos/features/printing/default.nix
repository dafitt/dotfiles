{ options, config, lib, pkgs, ... }:

with lib;
with lib.custom;
let
  cfg = config.custom.features.printing;
in
{
  options.custom.features.printing = with types; {
    enable = mkBoolOpt false "Enable the ability to print documents from your system";
  };

  config = mkIf cfg.enable {
    # <https://nixos.wiki/wiki/Printing>
    # Enable CUPS
    services.printing = {
      enable = true;
      drivers = [ pkgs.foomatic-db-ppds ];
    };

    # Avahi’s service discovery facilities
    services.avahi = {
      enable = true;
      nssmdns = true;
    };

    # Graphical user interface for CUPS administration
    programs.system-config-printer.enable = true;
  };
}
