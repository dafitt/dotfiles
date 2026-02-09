{ lib, ... }:
with lib;
{
  #meta.doc = builtins.toFile "doc.md" "Enables and configures the Limine bootloader.";

  boot.loader.limine = {
    enable = true;
    maxGenerations = mkDefault 50;

    extraConfig = ''
      remember_last_entry: yes
    '';
  };
}
