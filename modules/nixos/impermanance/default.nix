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
        "/var/lib/nixos"
        "/var/lib/systemd"
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
