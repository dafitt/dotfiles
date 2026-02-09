{ pkgs, ... }:
{
  meta.doc = "Enables flatpak support on your system.";

  services.flatpak.enable = true;

  environment.systemPackages = with pkgs; [ bazaar ];
}
