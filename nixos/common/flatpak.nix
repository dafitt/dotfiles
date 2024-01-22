{
  services.flatpak.enable = true;

  # Fix for [Flatpak apps can't launch the default browser](https://github.com/NixOS/nixpkgs/issues/189851)
  systemd.user.extraConfig = ''
    DefaultEnvironment="PATH=/run/current-system/sw/bin"
  '';
}
