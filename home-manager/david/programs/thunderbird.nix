{ config, pkgs, osConfig, secretDir, ... }:

{
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
      #! switched to sync settings with syncthing
      #settings = {
      #  # Security
      #  "browser.crashReports.unsubmittedCheck.autoSubmit2" = true;
      #  "datareporting.healthreport.uploadEnabled" = false;
      #  "privacy.donottrackheader.enabled" = true;
      #  "network.cookie.cookieBehavior" = 2; # disable cookies
      #  # 9205: Avoid information leakage in reply header
      #  "mailnews.reply_header_type" = 0;
      #  "mailnews.reply_header_originalmessage" = "";
      #  # Sort by date in descending order using threaded view
      #  #"mailnews.default_sort_type" = 18;
      #  #"mailnews.default_sort_order" = 2;
      #  #"mailnews.default_view_flags" = 1;
      #  #"mailnews.default_news_sort_type" = 18;
      #  #"mailnews.default_news_sort_order" = 2;
      #  #"mailnews.default_news_view_flags" = 1;
      #  # Tags
      #  "mailnews.tags.$label1.color" = "#${config.lib.stylix.colors.base08}";
      #  "mailnews.tags.$label1.tag" = "!!";
      #  "mailnews.tags.$label2.color" = "#${config.lib.stylix.colors.base09}";
      #  "mailnews.tags.$label2.tag" = "TODO";
      #  "mailnews.tags.$label3.color" = "#${config.lib.stylix.colors.base0A}";
      #  "mailnews.tags.$label3.tag" = "serious";
      #  "mailnews.tags.$label4.color" = "#${config.lib.stylix.colors.base0B}";
      #  "mailnews.tags.$label4.tag" = "personal";
      #  "mailnews.tags.$label5.color" = "#${config.lib.stylix.colors.base0E}";
      #  "mailnews.tags.$label5.tag" = "internet";

      #  "mail.tabs.autoHide" = false;
      #  "mail.spam.manualMark" = true;
      #  "mailnews.start_page.enabled" = false;
      #};
    };
  };

  wayland.windowManager.hyprland.settings = {
    bind = [ "ALT SUPER, M, exec, ${pkgs.thunderbird}/bin/thunderbird" ];
  };
}

# <https://github.com/alapshin/nixos-config/blob/255439473578d0d78173b88ddf7ca18f33bad6ef/users/alapshin/home/thunderbird.nix#L9>
