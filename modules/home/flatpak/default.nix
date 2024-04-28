{ options, config, lib, pkgs, osConfig ? { }, ... }:

with lib;
with lib.dafitt;
let
  cfg = config.dafitt.flatpak;
  osCfg = osConfig.dafitt.flatpak or null;
in
{
  options.dafitt.flatpak = with types; {
    enable = mkBoolOpt (osCfg.enable or true) "Enable flatpak support";
  };

  config = mkIf cfg.enable {
    # https://github.com/gmodena/nix-flatpak?tab=readme-ov-file#getting-started
    services.flatpak = {
      enable = true;
      #uninstallUnmanaged = true; # enable this for one activation for `error: No installed refs found for '<package>'`

      remotes = [
        { name = "flathub"; location = "https://dl.flathub.org/repo/flathub.flatpakrepo"; }
        { name = "flathub-beta"; location = "https://flathub.org/beta-repo/flathub-beta.flatpakrepo"; }
      ];

      #$ flatpak list
      #$ journalctl --user -eu flatpak-managed-install.service
      packages = [
        { appId = "com.github.tchx84.Flatseal"; origin = "flathub"; }
      ];

      overrides = {
        global = {
          # [Metadata keywords](https://docs.flatpak.org/en/latest/flatpak-command-reference.html?highlight=override#flatpak-metadata)
          Environment = {
            XCURSOR_PATH = "/run/host/user-share/icons:/run/host/share/icons";
          };
        };
        # override template:
        #"com.github.tchx84.Flatseal" = {
        #  Context.filesystems = [ ];
        #  Environment = { VARIABLE = ""; };
        #};
      };
    };

    home.shellAliases = {
      flatpak-install = "flatpak install --user --or-update --assumeyes";
    };

    wayland.windowManager.hyprland.settings.exec-once = [
      # [fix for flatpak open URLs with default browser](https://discourse.nixos.org/t/open-links-from-flatpak-via-host-firefox/15465/11)
      "${pkgs.systemd}/bin/systemctl --user import-environment PATH && ${pkgs.systemd}/bin/systemctl --user restart xdg-desktop-portal.service"
    ];
  };
}
