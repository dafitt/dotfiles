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

        complete --command chmod --long-option recursive --short-option R --no-files
        complete --command chmod --arguments "u+w dotfiles/"

        complete --command nixos-generate-config --long-option help --no-files
        complete --command nixos-generate-config --long-option no-filesystems --no-files
        complete --command nixos-generate-config --long-option root --require-parameter --arguments "/mnt"

        complete --command disko --long-option help --no-files
        complete --command disko --long-option dry-run --no-files
        complete --command disko --long-option yes-wipe-all-disks --no-files
        complete --command disko --long-option root-mountpoint --require-parameter --arguments "/mnt"
        complete --command disko --long-option mode --short-option m --require-parameter --no-files --arguments "destroy format mount unmount format,mount destroy,format,mount"
        complete --command disko --long-option flake --require-parameter --arguments "${flakePathArguments}"

        complete --command mkdir --arguments "/mnt/persist{/var/log/journal,/var/lib}"
        complete --command mount --arguments "{/mnt/persist,/mnt}/var/log/journal {/mnt/persist,/mnt}/var/lib"

        complete --command nixos-install --long-option help --no-files
        complete --command nixos-install --long-option no-root-passwd --no-files
        complete --command nixos-install --long-option flake --require-parameter --arguments "${flakePathArguments}"

        complete --command disko-install --long-option help --no-files
        complete --command disko-install --long-option disk --require-parameter --no-files --arguments "main"
        complete --command disko-install --long-option write-efi-boot-entries --no-files
        complete --command disko-install --long-option flake --require-parameter --arguments "${flakePathArguments}"
      '';
  };
}
