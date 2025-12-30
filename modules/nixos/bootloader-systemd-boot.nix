{ lib, ... }:
with lib;
{
  boot.loader.systemd-boot = {
    enable = true;
    configurationLimit = mkDefault 50;

    # https://github.com/NixOS/nixpkgs/blob/c32c39d6f3b1fe6514598fa40ad2cf9ce22c3fb7/nixos/modules/system/boot/loader/systemd-boot/systemd-boot.nix#L66
    editor = false;
  };
}
