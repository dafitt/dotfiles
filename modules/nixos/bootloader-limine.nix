{ lib, ... }:
with lib;
{
  boot.loader.limine = {
    enable = true;
    maxGenerations = mkDefault 50;

    extraConfig = ''
      remember_last_entry: yes
    '';
  };
}
