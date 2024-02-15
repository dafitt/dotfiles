{ pkgs, ... }: {
  services.flatpak.enable = true;
  xdg.portal.enable = true;

  # Fix for [Flatpak apps can't launch the default browser](https://github.com/NixOS/nixpkgs/issues/189851)
  systemd.user.extraConfig = ''
    DefaultEnvironment="PATH=/run/wrappers/bin:/etc/profiles/per-user/%u/bin:/nix/var/nix/profiles/default/bin:/run/current-system/sw/bin"
  '';
}
