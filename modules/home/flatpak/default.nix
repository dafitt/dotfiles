{ options, config, lib, pkgs, osConfig ? { }, ... }:

with lib;
with lib.custom;
let
  cfg = config.custom.flatpak;
  osCfg = osConfig.custom.flatpak or null;
in
{
  options.custom.flatpak = with types; {
    enable = mkBoolOpt (osCfg.enable or true) "Enable flatpak support";
  };

  config = mkIf cfg.enable {
    services.flatpak = {
      enable = true;
      remotes = [
        { name = "flathub"; location = "https://dl.flathub.org/repo/flathub.flatpakrepo"; }
        { name = "flathub-beta"; location = "https://flathub.org/beta-repo/flathub-beta.flatpakrepo"; }
      ];
      packages = [
        #$ flatpak list
        #{ appId = ""; origin = "flathub"; }
        "com.github.tchx84.Flatseal"
      ];
      overrides = {
        global = {
          #Context.sockets = [ "wayland" "fallback-x11" "x11" ];
          Environment = {
            XCURSOR_PATH = "/run/host/user-share/icons:/run/host/share/icons";
          };
        };
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
