{ config, lib, pkgs, osConfig ? { }, ... }:

with lib;
with lib.dafitt;
let
  cfg = config.dafitt.flatpak;
  osCfg = osConfig.dafitt.flatpak or null;
in
{
  options.dafitt.flatpak = with types; {
    enable = mkBoolOpt (osCfg.enable or false) "Whether to enable flatpak support.";
  };

  config = mkIf cfg.enable {
    # https://github.com/gmodena/nix-flatpak?tab=readme-ov-file#getting-started
    services.flatpak = {
      enable = true;
      #uninstallUnmanaged = true; # enable this for one activation if you get `error: No installed refs found for '<package>'`

      remotes = [
        { name = "flathub"; location = "https://dl.flathub.org/repo/flathub.flatpakrepo"; }
        { name = "flathub-beta"; location = "https://flathub.org/beta-repo/flathub-beta.flatpakrepo"; }
      ];

      #$ flatpak list
      #$ journalctl --user -eu flatpak-managed-install.service
      packages = [
        { origin = "flathub"; appId = "com.github.tchx84.Flatseal"; }
        { origin = "flathub"; appId = "io.github.giantpinkrobots.flatsweep"; }
        { origin = "flathub"; appId = "io.github.flattool.Warehouse"; }
      ];

      overrides = {
        global = {
          # [Metadata keywords](https://docs.flatpak.org/en/latest/flatpak-command-reference.html?highlight=override#flatpak-metadata)

          Environment = { };
          Context.filesystems = [
            "/nix/store:ro"
          ];
        };
      };
    };

    xdg.portal = {
      enable = true;
      extraPortals = [ pkgs.xdg-desktop-portal-gtk ]; # Fixes OpenURI and cursor theme
    };

    home.shellAliases = {
      flatpak-install = "flatpak install --user --or-update --assumeyes";
    };
  };
}
