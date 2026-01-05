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
      diskManagement
      fwupd
    ];

  services.getty.autologinUser = mkForce "david";

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
      ${getExe pkgs.glow} - << 'EOF'

      0. Internet: Wifi

        ```sh
        nmcli device wifi list
        nmcli device wifi connect <SSID> password <PASSWORD>
        nmcli device status
        ```

      1. Copy the dotfiles to the current working directory (writeable)

        ```sh
        cp -r /iso/dotfiles .
        chmod u+x -R dotfiles/
        ```

      2. Add and check machine to the dotfiles

        _dotfiles/hosts/\<your-host>/configuration.nix_
        _dotfiles/hosts/\<your-host>/hardware-configuration.nix_
        _dotfiles/hosts/\<your-host>/disk-configuration.nix_ (optional, only when using disko)

        - Generate a configuration file for your host:

          ```sh
          nixos-generate-config --no-filesystems
          cp /etc/nixos/hardware-configuration.nix dotfiles/hosts/<your-configured-host>/hardware-configuration.nix
          ```

      3. Installation

          - Either with `nixos-install`

            ```sh
            sudo disko --mode destroy,format,mount --flake dotfiles#<your-configured-host>
            sudo mkdir -p /mnt/nix/persist{/var/log/journal,/var/lib}
            sudo mount -o bind {/mnt/nix/persist,}/var/log/journal
            sudo mount -o bind {/mnt/nix/persist,}/var/lib
            sudo nixos-install --no-root-passwd --flake ./dotfiles#<your-configured-host>
            ```

          - Alternatively with `disko-install`, if you have configured a disk with disko.

            ```sh
            sudo disko-install --flake dotfiles#<your-configured-host> --disk main /dev/disk/by-id/<your-main-disk-id>
            ```

              - Add further `--disk <disk> /dev/disk/by-id/<your-disk-id>` to the `disko-install` command to override the attribute `disko.devices.disk.<disk>.device`.

              <https://github.com/nix-community/disko/blob/master/docs/disko-install.md>

      4. (optional) Add flake to host

        ```sh
        sudo cp -r dotfiles /mnt/home/...
        ```

      EOF
    '')
  ];

  services.getty.helpLine = "Type 'help-install' for help with installation.";
}
