{ ... }: {
  #$ flake build-system [#<name>]
  #$ nix build .#nixosConfigurations.<name>.config.system.build.toplevel
  #$ nixos-rebuild build --flake .[#<name>] --show-trace
  #$ nixos-rebuild build-vm --flake .[#<name>]

  #$ flake test [#<name>]
  #$ flake switch [#<name>]
  #$ flake boot [#<name>]
  #$ sudo nixos-rebuild test --flake .[#<name>]
  #$ sudo nixos-rebuild switch --flake .[#<name>]
  #$ sudo nixos-rebuild boot --flake .[#<name>]

  imports = [ ./hardware-configuration.nix ];

  custom = { };

  system.stateVersion = "23.11";
}
