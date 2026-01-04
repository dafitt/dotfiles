{
  lib,
  inputs,
  osConfig,
  ...
}:

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

  dafitt = {
    browser-firefox.autostart = false;
    fileManager-nautilus.autostart = false;
    gditor-zed-editor.autostart = false;
  };

  programs.fish.completions = {
    nixos-install =
      let
        flakePathArguments = lib.concatStringsSep " " [
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

        complete --command chmod --short R --long recursive
        complete --command chmod --arguments "u+w dotfiles/"

        complete --command nixos-generate-config --long help
        complete --command nixos-generate-config --long no-filesystems
        complete --command nixos-generate-config --long root --require-parameter --arguments "/mnt"

        complete --command disko --long help
        complete --command disko --long dry-run
        complete --command disko --long yes-wipe-all-disks
        complete --command disko --long root-mountpoint --require-parameter --arguments "/mnt"
        complete --command disko --long mode --short m --require-parameter --arguments "destroy format mount unmount format,mount destroy,format,mount"
        complete --command disko --long flake --short f --require-parameter --arguments "${flakePathArguments}"

        complete --command nixos-install --long help
        complete --command nixos-install --long no-root-passwd
        complete --command nixos-install --long flake --short f --require-parameter --arguments "${flakePathArguments}"

        complete --command disko-install --long help
        complete --command disko-install --long disk --require-parameter --arguments "main"
        complete --command disko-install --long write-efi-boot-entries
        complete --command disko-install --long flake --short f --require-parameter --arguments "${flakePathArguments}"
      '';
  };
}
