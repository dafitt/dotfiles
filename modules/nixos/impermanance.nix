{
  config,
  lib,
  inputs,
  ...
}:

# https://wiki.nixos.org/wiki/Impermanence
# https://saylesss88.github.io/installation/unencrypted/impermanence.html
# https://xeiaso.net/blog/paranoid-nixos-2021-07-18/

#! before your first 'nixos-rebuild switch' if transitioning to impermanence
#$ sudo cp --archive --parents {,/nix/persist}/<DIR>

with lib;
{
  imports = with inputs; [ impermanence.nixosModules.impermanence ];

  config = mkMerge [
    {
      users.mutableUsers = false; # mutableUsers not really compatible with Impermanence

      environment.persistence."/nix/persist" = {

        # Basic needed state directories and files
        # https://nixos.org/manual/nixos/unstable/#ch-system-state
        directories = [
          #! "/var/lib/nixos"
          #! "/var/lib/systemd"
          "/var/lib"
          "/var/log/journal"
        ];
      };
      # Some important /etc files linked this way, because of timing issues of environment.persistence
      # They do not need to exist in /nix/persist.
      environment.etc = {
        "machine-id".source = "/nix/persist/etc/machine-id";

        # machine ssh keys
        "ssh/ssh_host_ed25519_key".source = "/nix/persist/etc/ssh/ssh_host_ed25519_key";
        "ssh/ssh_host_ed25519_key.pub".source = "/nix/persist/etc/ssh/ssh_host_ed25519_key.pub";
        "ssh/ssh_host_rsa_key".source = "/nix/persist/etc/ssh/ssh_host_rsa_key";
        "ssh/ssh_host_rsa_key.pub".source = "/nix/persist/etc/ssh/ssh_host_rsa_key.pub";
      };
    }

    (mkIf config.networking.networkmanager.enable {
      environment.persistence."/nix/persist".directories = [
        {
          directory = "/etc/NetworkManager/system-connections";
          mode = "u=rwx,g=,o=";
        }
      ];
    })
  ];
}
