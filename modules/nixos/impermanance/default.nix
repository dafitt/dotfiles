# https://wiki.nixos.org/wiki/Impermanence
# https://saylesss88.github.io/installation/unencrypted/impermanence.html
# https://xeiaso.net/blog/paranoid-nixos-2021-07-18/

#! before your first 'nixos-rebuild switch' if transitioning to impermanence
#$ sudo cp --archive --parents {,/nix/persist}/<DIR>

{ config, lib, ... }:

with lib;
{
  config = mkMerge [
    {
      environment.persistence."/nix/persist" = {
        # Default to false, because i don't want to use impermanence on every system
        enable = mkDefault false;

        # Basic needed state directories and files
        # https://nixos.org/manual/nixos/unstable/#ch-system-state
        directories = [
          #! "/var/lib/nixos"
          #! "/var/lib/systemd"
          "/var/lib"
          "/var/log/journal"
        ];
      };
    }
    (mkIf config.environment.persistence."/nix/persist".enable {
      # Some important /etc files linked this way, because of timing issues of environment.persistence
      # They do not need to exist in /nix/persist.
      environment.etc = {
        "machine-id".source = "/nix/persist/etc/machine-id";

        # users and groups
        "passwd".source = "/nix/persist/etc/passwd";
        "group".source = "/nix/persist/etc/group";
        "shadow".source = "/nix/persist/etc/shadow";
        "gshadow".source = "/nix/persist/etc/gshadow";
        "subuid".source = "/nix/persist/etc/subuid";
        "subgid".source = "/nix/persist/etc/subgid";

        # machine ssh keys
        "ssh/ssh_host_ed25519_key".source = "/nix/persist/etc/ssh/ssh_host_ed25519_key";
        "ssh/ssh_host_ed25519_key.pub".source = "/nix/persist/etc/ssh/ssh_host_ed25519_key.pub";
        "ssh/ssh_host_rsa_key".source = "/nix/persist/etc/ssh/ssh_host_rsa_key";
        "ssh/ssh_host_rsa_key.pub".source = "/nix/persist/etc/ssh/ssh_host_rsa_key.pub";
      };
    })
  ];
}
