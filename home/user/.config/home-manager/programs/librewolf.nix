{ pkgs, ... }: {

  # a fork of Firefox, focused on privacy, security and freedom
  # https://librewolf.net/
  programs.librewolf = {
    enable = true;

    settings = {
      # detailed settings <https://searchfox.org/mozilla-release/source/browser/app/profile/firefox.js>

      # Personal settings
      "browser.backspace_action" = 0;
      "browser.startup.page" = 3; # resore last Session
      "browser.urlbar.shortcuts.quickactions" = true;
      "general.autoScroll" = true;
      "middlemouse.paste" = false;
      #"network.trr.mode" = 3;
      "privacy.clearOnShutdown.downloads" = false;
      "privacy.clearOnShutdown.history" = false;
      "svg.context-properties.content.enabled" = true; # fully support the dark theme
      #"widget.use-xdg-desktop-portal.file-picker" = true;

      # Sync
      "identity.fxaccounts.enabled" = true;
      "browser.uiCustomization.state" = ''
        { "placements":{"widget-overflow-fixed-list":[],"unified-extensions-area":["_a6c4a591-f1b2-4f03-b3ff-767e5bedf4e7_-browser-action","sponsorblocker_ajay_app-browser-action","_7b1bf0b6-a1b9-42b0-b75d-252036438bdc_-browser-action","_605a075b-09d9-4443-bed6-4baa743f7d79_-browser-action","myallychou_gmail_com-browser-action","cookieautodelete_kennydo_com-browser-action","jid1-kkzogwgsw3ao4q_jetpack-browser-action","_74145f27-f039-47ce-a470-a662b129930a_-browser-action","_94249bf3-29a3-4bb5-aa30-013883e8f2f4_-browser-action","_2cf5dbed-78fe-4bd5-9524-38fdf837be98_-browser-action","_ab0ae774-f22f-479b-9b1b-6aff11bf6f5c_-browser-action"],"nav-bar":["simple-tab-groups_drive4ik-browser-action","back-button","forward-button","stop-reload-button","customizableui-special-spring1","addon_darkreader_org-browser-action","ublock0_raymondhill_net-browser-action","_73a6fe31-595d-460b-a920-fcc0f8843232_-browser-action","urlbar-container","_4853d046-c5a3-436b-bc36-220fd935ee1d_-browser-action","history-panelmenu","screenshot-button","downloads-button","customizableui-special-spring2","_d634138d-c276-4fc8-924b-40a0ea21d284_-browser-action","fxa-toolbar-menu-button","unified-extensions-button"],"toolbar-menubar":["menubar-items"],"TabsToolbar":["firefox-view-button","tabbrowser-tabs","new-tab-button","alltabs-button"],"PersonalToolbar":["personal-bookmarks"]},"seen":["save-to-pocket-button","developer-button","_a6c4a591-f1b2-4f03-b3ff-767e5bedf4e7_-browser-action","sponsorblocker_ajay_app-browser-action","_7b1bf0b6-a1b9-42b0-b75d-252036438bdc_-browser-action","_73a6fe31-595d-460b-a920-fcc0f8843232_-browser-action","_605a075b-09d9-4443-bed6-4baa743f7d79_-browser-action","myallychou_gmail_com-browser-action","cookieautodelete_kennydo_com-browser-action","jid1-kkzogwgsw3ao4q_jetpack-browser-action","simple-tab-groups_drive4ik-browser-action","_4853d046-c5a3-436b-bc36-220fd935ee1d_-browser-action","_d634138d-c276-4fc8-924b-40a0ea21d284_-browser-action","ublock0_raymondhill_net-browser-action","addon_darkreader_org-browser-action","_74145f27-f039-47ce-a470-a662b129930a_-browser-action","_94249bf3-29a3-4bb5-aa30-013883e8f2f4_-browser-action","_2cf5dbed-78fe-4bd5-9524-38fdf837be98_-browser-action","_ab0ae774-f22f-479b-9b1b-6aff11bf6f5c_-browser-action"],"dirtyAreaCache":["nav-bar","PersonalToolbar","toolbar-menubar","TabsToolbar","unified-extensions-area"],"currentVersion":19,"newElementCount":8}
      '';

      # <https://github.com/yokoffing/Betterfox/blob/main/librewolf.overrides.cfg>
      # Fastfox
      "layout.css.grid-template-masonry-value.enabled" = true;
      "dom.enable_web_task_scheduling" = true;
      "layout.css.animation-composition.enabled" = true;

      # Securefox
      "privacy.trackingprotection.emailtracking.enabled" = true;
      "urlclassifier.trackingSkipURLs" = "*.reddit.com, *.twitter.com, *.twimg.com";
      "urlclassifier.features.socialtracking.skipURLs" = "*.instagram.com, *.twitter.com, *.twimg.com";
      "security.OCSP.enabled" = 0;
      "security.OCSP.require" = false;
      "security.pki.crlite_mode" = 2;
      "privacy.resistFingerprinting" = false; # problems firefox sync login
      "webgl.disabled" = false;
      "media.eme.enabled" = true;
      "dom.security.https_only_mode_error_page_user_suggestions" = true;
      "signon.generation.enabled" = false;
      "signon.rememberSignons" = false;
      "media.peerconnection.ice.no_host" = false;
      "permissions.default.geo" = 2;
      "permissions.default.desktop-notification" = 2;
      "dom.push.enabled" = false;

      # Peskyfox
      "layout.css.prefers-color-scheme.content-override" = 2;
      "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
      "browser.compactmode.show" = true;
      "findbar.highlightAll" = true;
      "full-screen-api.transition-duration.enter" = "0 0";
      "full-screen-api.transition-duration.leave" = "0 0";
      "full-screen-api.warning.delay" = 0;
      "full-screen-api.warning.timeout" = 0;
      "browser.urlbar.suggest.engines" = false;
      "browser.urlbar.suggest.topsites" = false;
      "browser.urlbar.suggest.calculator" = true;
      "browser.urlbar.unitConversion.enabled" = true;
      "media.autoplay.blocking_policy" = 0;
      "browser.download.autohideButton" = true;
      "browser.download.open_pdf_attachments_inline" = true;
      "browser.tabs.loadBookmarksInTabs" = true;
      "browser.bookmarks.openInTabClosesMenu" = false;
      "editor.truncate_user_pastes" = false;
      "clipboard.plainTextOnly" = true;
    };
  };

  wayland.windowManager.hyprland.settings = {
    bind = [ "ALT SUPER, B, exec, ${pkgs.librewolf}/bin/librewolf" ];
    windowrulev2 = [
      "idleinhibit fullscreen, class:librewolf, title:(Youtube)"
    ];
  };
}
