#$ nixos-rebuild --flake .#defaults repl
#> :p config.dafitt

{
  dafitt.bootloader.systemd-boot.enable = true;

  fileSystems."/" = {
    device = "/dev/null";
    fsType = "ext4";
  };

  system.stateVersion = "24.11";
}
