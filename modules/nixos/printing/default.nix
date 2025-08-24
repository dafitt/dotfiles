{
  config,
  lib,
  pkgs,
  ...
}:

with lib;
with lib.dafitt;
let
  cfg = config.dafitt.printing;
in
{
  options.dafitt.printing = with types; {
    enable = mkEnableOption "the ability to print documents from your system";
  };

  config = mkIf cfg.enable {
    # https://wiki.nixos.org/wiki/Printing

    # Enable CUPS
    services.printing = {
      enable = true;
      drivers = with pkgs; [
        splix
        #foomatic-db-ppds
      ];
    };

    # Avahi’s service discovery facilities
    services.avahi = {
      enable = true;
      nssmdns4 = true;
    };

    # Graphical user interface for CUPS administration
    programs.system-config-printer.enable = true;
  };
}
