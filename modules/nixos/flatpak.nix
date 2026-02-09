{ pkgs, ... }:
{
  #meta.doc = builtins.toFile "doc.md" "Enables flatpak support on your system.";

  services.flatpak.enable = true;

  environment.systemPackages = with pkgs; [ bazaar ];
}
