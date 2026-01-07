{
  lib,
  inputs,
  osConfig,
  ...
}:
with lib;
{
  home.stateVersion = osConfig.system.stateVersion;

  imports =
    with inputs;
    with inputs.self.homeModules;
    [
      SHARED
      development
      web
    ];

  programs.fish.completions = {
    nixos-install =
      let
        flakePathArguments = concatStringsSep " " [
          "/iso/dotfiles#"
          "/iso/dotfiles#DavidDESKTOP"
          "/iso/dotfiles#DavidLEGION"
          "./dotfiles#"
          "./dotfiles#DavidDESKTOP"
          "./dotfiles#DavidLEGION"
        ];
      in
      ''
        complete --command cp --arguments "/iso/dotfiles ."

        complete --command chmod --long recursive --short R --no-files
        complete --command chmod --arguments "u+w dotfiles/"

        complete --command nixos-generate-config --long help --no-files
        complete --command nixos-generate-config --long no-filesystems --no-files
        complete --command nixos-generate-config --long root --require-parameter --arguments "/mnt"

        complete --command disko --long help --no-files
        complete --command disko --long dry-run --no-files
        complete --command disko --long yes-wipe-all-disks --no-files
        complete --command disko --long root-mountpoint --require-parameter --arguments "/mnt"
        complete --command disko --long mode --short m --require-parameter --no-files --arguments "destroy format mount unmount format,mount destroy,format,mount"
        complete --command disko --long flake --require-parameter --arguments "${flakePathArguments}"

        complete --command mkdir --arguments "/mnt/nix/persist{/var/log/journal,/var/lib}"
        complete --command mount --arguments "{/mnt/nix/persist,/mnt}/var/log/journal {/mnt/nix/persist,/mnt}/var/lib"

        complete --command nixos-install --long help --no-files
        complete --command nixos-install --long no-root-passwd --no-files
        complete --command nixos-install --long flake --require-parameter --arguments "${flakePathArguments}"

        complete --command disko-install --long help --no-files
        complete --command disko-install --long disk --require-parameter --no-files --arguments "main"
        complete --command disko-install --long write-efi-boot-entries --no-files
        complete --command disko-install --long flake --require-parameter --arguments "${flakePathArguments}"
      '';
  };
}
