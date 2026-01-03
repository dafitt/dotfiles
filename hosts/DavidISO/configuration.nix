{
  lib,
  pkgs,
  inputs,
  modulesPath,
  ...
}:

#$ nix build .#nixosConfigurations.DavidISO.config.formats.install-iso
with lib;
{
  nixpkgs.hostPlatform = "x86_64-linux";

  imports =
    with inputs;
    with inputs.self.nixosModules;
    [
      nixos-generators.nixosModules.all-formats
      "${modulesPath}/installer/cd-dvd/installation-cd-base.nix"

      SHARED
      development
      fwupd
    ];

  # https://github.com/NixOS/nixpkgs/blob/master/nixos/modules/installer/cd-dvd/iso-image.nix#L558
  isoImage = {
    squashfsCompression = "zstd"; # -Xcompression-level 1..22
    # includeSystemBuildDependencies = true; # VERY LARGE iso, but ability, to build without internet.

    contents = [
      {
        source = ../../.;
        target = "/dotfiles/";
      }
    ];
  };

  environment.systemPackages = with pkgs; [
    disko
    (writeScriptBin "help-install" ''
      ${getExe pkgs.glow} - <<'EOF'

      1. Generate a configuration file for your host.

      ```sh
      nixos-generate-config --no-filesystems
      cp /etc/nixos/hardware-configuration.nix /dotfiles/hosts/<your-configured-host>/hardware-configuration.nix
      ```

      2. Run either `nixos-install`

      ```sh
      nixos-install --flake /dotfiles#<your-configured-host>
      ```

      Or `disko-install`, if you have configured a disk with disko.

      ```sh
      disko-install --flake /dotfiles#<your-configured-host> [--write-efi-boot-entries]
      ```

      - Add `--disk <disk> /dev/disk/by-id/<your-disk-id>` to the `disko-install` command to override the attribute `disko.devices.disk.<disk>.device`.
      - Add `--mode mount` to the `disko-install` command if you want to repair a system.

      <https://github.com/nix-community/disko/blob/master/docs/disko-install.md>

      EOF
    '')
  ];

  services.getty.helpLine = "Type 'help-install' for help with installation.";
}
