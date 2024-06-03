{ options, config, lib, pkgs, inputs, ... }:

with lib;
with lib.dafitt;
{
  environment.systemPackages = with pkgs; with inputs; [
    snowfall-flake.packages.${system}.default
  ];

  programs.git.enable = true;

  nix = {
    package = pkgs.nixVersions.latest;

    settings = {
      experimental-features = [ "nix-command" "flakes" ];
      http-connections = 50;
      warn-dirty = false;
      log-lines = 50;
      auto-optimise-store = true;
      trusted-users = [ "root" ];
      allowed-users = [ "@wheel" config.dafitt.users.main.username ];
    }
    // optionalAttrs config.dafitt.Development.direnv.enable {
      keep-outputs = true;
      keep-derivations = true;
    };

    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };

    # disable nix-channel, we use flakes instead.
    channel.enable = false;
  };

  # but NIX_PATH is still used by many useful tools, so we set it to the same value as the one used by this flake.
  # Make `nix repl '<nixpkgs>'` use the same nixpkgs as the one used by this flake.
  environment.etc."nix/inputs/nixpkgs".source = "${inputs.nixpkgs}";

  # repair command-not-found database
  programs.command-not-found.dbPath = inputs.programsdb.packages.${pkgs.system}.programs-sqlite;
}
