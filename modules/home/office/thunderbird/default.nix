{ options, config, lib, pkgs, ... }:

with lib;
with lib.custom;
let
  cfg = config.custom.office.thunderbird;
in
{
  options.custom.office.thunderbird = with types; {
    enable = mkBoolOpt config.custom.office.enableSuite "Enable thunderbird";
  };

  config = mkIf cfg.enable {
    accounts.email.accounts = {
      "Posteo" = {
        realName = "David Schaller";
        address = "david.schaller@posteo.net";
        userName = "david.schaller@posteo.net";
        primary = true;
        signature = {
          text = ''
            Mit freundlichen Grüßen / Kind regards
            David Schaller
          '';
          showSignature = "append";
        };

        imap = {
          host = "posteo.de";
          port = 993;
        };
        smtp = {
          host = "posteo.de";
          port = 465;
        };
        #thunderbird.enable = true;
      };
    };

    # A full-featured e-mail client
    # https://www.thunderbird.net/
    programs.thunderbird = {
      enable = true;
      package = pkgs.thunderbird;

      profiles."david" = {
        isDefault = true;
        #! profile settings are syncing manually
      };
    };

    wayland.windowManager.hyprland.settings = {
      bind = [ "ALT SUPER, M, exec, ${pkgs.thunderbird}/bin/thunderbird" ];
    };
  };
}
