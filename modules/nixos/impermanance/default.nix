# https://wiki.nixos.org/wiki/Impermanence
# https://saylesss88.github.io/installation/unencrypted/impermanence.html
# https://xeiaso.net/blog/paranoid-nixos-2021-07-18/

#! before your first nixos-rebuild switch
#$ sudo mkdir -p /nix/persist/<DIRS>
#$ sudo cp -a /<DIRS>/* /nix/persist/<DIRS>
{ lib, ... }:

with lib;
{
  config = {
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
      files = [
        "/etc/machine-id"

        # users and groups
        "/etc/passwd"
        "/etc/group"
        "/etc/shadow"
        "/etc/gshadow"
        "/etc/subuid"
        "/etc/subgid"
      ];
    };
  };
}
