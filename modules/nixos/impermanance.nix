{
  config,
  lib,
  inputs,
  ...
}:

with lib;
{
  meta.doc = ''
    Adds persistence under `/persist` to your impermanent system and configuration.
    <https://wiki.nixos.org/wiki/Impermanence>
    <https://saylesss88.github.io/installation/unencrypted/impermanence.html>
    <https://xeiaso.net/blog/paranoid-nixos-2021-07-18/>

    # ATTENTION

    When transitioning to impermanence: Before your `nixos-rebuild` and reboot, copy relevant directories and files to `/persist`.

    ```sh
    sudo cp --archive --parents {,/persist}/<DIR/FILE>
    ```
  '';

  imports = with inputs; [ impermanence.nixosModules.impermanence ];

  config = mkMerge [
    {
      users.mutableUsers = false; # mutableUsers not really compatible with Impermanence

      fileSystems."/persist".neededForBoot = true;

      # https://github.com/nix-community/impermanence?tab=readme-ov-file#module-usage
      environment.persistence."/persist" = {

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
        ];
      };

      services.openssh.hostKeys = [
        {
          path = "/persist/etc/ssh_host_ed25519_key";
          type = "ed25519";
        }
        {
          path = "/persist/etc/ssh_host_rsa_key";
          type = "rsa";
          bits = 4096;
        }
      ];
    }

    (mkIf config.networking.networkmanager.enable {
      environment.persistence."/persist".directories = [
        {
          directory = "/etc/NetworkManager/system-connections";
          mode = "u=rwx,g=,o=";
        }
      ];
    })

    (mkIf config.services.greetd.enable {
      environment.persistence."/persist".directories = [
        {
          directory = "/var/cache/tuigreet";
          user = "greeter";
          group = "greeter";
        }
      ];
    })
  ];
}
