{ lib, config, nixpkgs, ... }: {

  nix = {
    settings = {
      experimental-features = [ "nix-command" "flakes" "repl-flake" ];
      auto-optimise-store = lib.mkDefault true;
      warn-dirty = false;
    };

    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 1w";
    };

    # Make `nix run nixpkgs#nixpkgs` use the same nixpkgs as the one used by this flake.
    registry."nixpkgs".flake = nixpkgs;

    # disable nix-channel, we use flakes instead.
    channel.enable = false;

  };

  # Make `nix repl '<nixpkgs>'` use the same nixpkgs as the one used by this flake.
  environment.etc."nix/inputs/nixpkgs".source = "${nixpkgs}";
  nix.nixPath = [ "/etc/nix/inputs" ];

  # Limit the number of generations to keep
  boot.loader.systemd-boot.configurationLimit = lib.mkDefault 10;
  boot.loader.grub.configurationLimit = lib.mkDefault config.boot.loader.systemd-boot.configurationLimit;

  # Multitheaded and faster building (make)
  environment.variables.MAKEFLAGS = "-j$(expr $(nproc) \+ 1)";
}
