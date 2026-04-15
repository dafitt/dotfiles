{ inputs, ... }:
{
  #meta.doc = builtins.toFile "doc.md" "A collection of default modules beeing shared across hosts.";

  imports = with inputs.self.nixosModules; [
    appimage
    audio
    certificates
    coreutils
    desktopEnvironment-hyprland
    desktopEnvironment-niri
    documentation
    flatpak
    fonts
    home-manager
    hostName
    kernel
    locale
    localsend
    locate
    nix
    shell-fish
    shell-fish
    stylix
    sudo
    syncthing
    systemd
    tailscale
    time
    user-david
    user-guest
    user-root
  ];
}
