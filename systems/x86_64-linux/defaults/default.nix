#$ nixos-rebuild --flake .#defaults repl
#> :p config.dafitt

{
  fileSystems."/" = {
    device = "/dev/null";
    fsType = "ext4";
  };

  system.stateVersion = "24.11";
}
