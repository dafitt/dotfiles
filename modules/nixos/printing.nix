{ pkgs, ... }:
{
  meta.doc = ''
    Enables printing support from your system.

    <https://wiki.nixos.org/wiki/Printing>
  '';

  services.printing = {
    enable = true;
    drivers = with pkgs; [
      splix
      #foomatic-db-ppds
    ];
  };

  services.avahi = {
    enable = true;
    nssmdns4 = true;
  };

  # Graphical user interface for CUPS administration
  programs.system-config-printer.enable = true;
}
