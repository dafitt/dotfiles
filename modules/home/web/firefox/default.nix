{ options, config, lib, pkgs, host, osConfig ? { }, ... }:

with lib;
with lib.dafitt;
let
  cfg = config.dafitt.web.firefox;

  betterfox = pkgs.fetchFromGitHub {
    owner = "yokoffing";
    repo = "Betterfox";
    rev = "116.1";
    hash = "sha256-Ai8Szbrk/4FhGhS4r5gA2DqjALFRfQKo2a/TwWCIA6g=";
  };
in
{
  options.dafitt.web.firefox = with types; {
    enable = mkBoolOpt config.dafitt.web.enableSuite "Enable the firefox web browser";
    autostart = mkBoolOpt false "Start firefox on login";
    defaultApplication = mkBoolOpt false "Set firefox as the default application for its mimetypes";
  };

  config = mkIf cfg.enable {
    programs.firefox = {
      enable = true;
      profiles.${config.home.username} = {
        name = config.home.username;
        id = 0;
        isDefault = true;
        settings = mkAfter {
          #
          # General / personal settings
          #
          "browser.tabs.insertAfterCurrent" = true;
          "browser.urlbar.trimURLs" = false; # show whole URL in address bar
          "general.autoScroll" = true; # enable middle-click scrolling
          "toolkit.legacyUserProfileCustomizations.stylesheets" = true; # enable userChrome customisations

          # ui arrangement
          "browser.uiCustomization.state" = ''
            {"placements":{"widget-overflow-fixed-list":[],"unified-extensions-area":["jid1-mnnxcxisbpnsxq_jetpack-browser-action","sponsorblocker_ajay_app-browser-action","_7b1bf0b6-a1b9-42b0-b75d-252036438bdc_-browser-action","_605a075b-09d9-4443-bed6-4baa743f7d79_-browser-action","myallychou_gmail_com-browser-action","cookieautodelete_kennydo_com-browser-action","jid1-kkzogwgsw3ao4q_jetpack-browser-action","_74145f27-f039-47ce-a470-a662b129930a_-browser-action","_94249bf3-29a3-4bb5-aa30-013883e8f2f4_-browser-action","_2cf5dbed-78fe-4bd5-9524-38fdf837be98_-browser-action","_ab0ae774-f22f-479b-9b1b-6aff11bf6f5c_-browser-action","_b9acf540-acba-11e1-8ccb-001fd0e08bd4_-browser-action","_34daeb50-c2d2-4f14-886a-7160b24d66a4_-browser-action","jid1-bofifl9vbdl2zq_jetpack-browser-action"],"nav-bar":["simple-tab-groups_drive4ik-browser-action","_3c078156-979c-498b-8990-85f7987dd929_-browser-action","back-button","forward-button","stop-reload-button","customizableui-special-spring1","addon_darkreader_org-browser-action","ublock0_raymondhill_net-browser-action","_73a6fe31-595d-460b-a920-fcc0f8843232_-browser-action","urlbar-container","_4853d046-c5a3-436b-bc36-220fd935ee1d_-browser-action","history-panelmenu","screenshot-button","downloads-button","customizableui-special-spring2","_d634138d-c276-4fc8-924b-40a0ea21d284_-browser-action","fxa-toolbar-menu-button","unified-extensions-button","reset-pbm-toolbar-button","_a6c4a591-f1b2-4f03-b3ff-767e5bedf4e7_-browser-action"],"toolbar-menubar":["menubar-items"],"TabsToolbar":["firefox-view-button","tabbrowser-tabs","new-tab-button","alltabs-button"],"PersonalToolbar":["personal-bookmarks"]},"seen":["save-to-pocket-button","developer-button","_a6c4a591-f1b2-4f03-b3ff-767e5bedf4e7_-browser-action","sponsorblocker_ajay_app-browser-action","_7b1bf0b6-a1b9-42b0-b75d-252036438bdc_-browser-action","_73a6fe31-595d-460b-a920-fcc0f8843232_-browser-action","_605a075b-09d9-4443-bed6-4baa743f7d79_-browser-action","myallychou_gmail_com-browser-action","cookieautodelete_kennydo_com-browser-action","jid1-kkzogwgsw3ao4q_jetpack-browser-action","simple-tab-groups_drive4ik-browser-action","_4853d046-c5a3-436b-bc36-220fd935ee1d_-browser-action","_d634138d-c276-4fc8-924b-40a0ea21d284_-browser-action","ublock0_raymondhill_net-browser-action","addon_darkreader_org-browser-action","_74145f27-f039-47ce-a470-a662b129930a_-browser-action","_94249bf3-29a3-4bb5-aa30-013883e8f2f4_-browser-action","_2cf5dbed-78fe-4bd5-9524-38fdf837be98_-browser-action","_ab0ae774-f22f-479b-9b1b-6aff11bf6f5c_-browser-action","_b9acf540-acba-11e1-8ccb-001fd0e08bd4_-browser-action","_34daeb50-c2d2-4f14-886a-7160b24d66a4_-browser-action","jid1-mnnxcxisbpnsxq_jetpack-browser-action","_3c078156-979c-498b-8990-85f7987dd929_-browser-action","jid1-bofifl9vbdl2zq_jetpack-browser-action"],"dirtyAreaCache":["nav-bar","PersonalToolbar","toolbar-menubar","TabsToolbar","unified-extensions-area"],"currentVersion":20,"newElementCount":9}
          '';

          # resore last session
          "browser.startup.page" = 3;
          "places.history.enabled" = true;
          "privacy.clearOnShutdown.history" = false;

          # firefox sync
          "identity.fxaccounts.enabled" = true;
          "identity.fxaccounts.account.device.name" = host;
          "services.sync.prefs.sync.browser.uiCustomization.state" = true; # sync customized toolbar settings
          "noscript.sync.enabled" = true;

          # dark theme
          "devtools.theme" = "dark";
          #"extensions.activeThemeID" = "firefox-compact-dark@mozilla.org"; # browser dark theme
          #"layout.css.prefers-color-scheme.content-override" = 0; # set default perefered color scheme to dark
          "svg.context-properties.content.enabled" = true; # fully support the dark theme

          #
          # Disable some useless stuff
          #
          "app.normandy.first_run" = false; # disable first run intro
          "extensions.pocket.enabled" = false; # disable pocket, save links, send tabs
          "extensions.shield-recipe-client.enabled" = false;
          "browser.aboutConfig.showWarning" = false; # disable warning when opening about:config
          "browser.shell.checkDefaultBrowser" = false; # do not check if default browser
          "middlemouse.paste" = false; # disable middle click paste
          "dom.push.connection.enabled" = false;
          "device.sensors.enabled" = false; # This isn't a phone
          "geo.enabled" = false; # Disable geolocation alltogether

          # disable the "new tab page" feature and show a blank tab instead
          "browser.newtabpage.enabled" = false;
          "browser.newtabpage.activity-stream.showSponsored" = false;
          "browser.newtabpage.activity-stream.showSponsoredTopSites" = false;
          "browser.newtab.url" = "about:blank";

          # don't predict network requests
          "network.predictor.enabled" = false;
          "browser.urlbar.speculativeConnect.enabled" = false;

          # Extensions are managed with Nix, so don't update.
          "extensions.update.autoUpdateDefault" = false;
          "extensions.update.enabled" = false;
        };

        extraConfig = builtins.concatStringsSep "\n" [
          #
          # [Betterfox](https://github.com/yokoffing/Betterfox)
          #
          (builtins.readFile "${betterfox}/Fastfox.js")
          (builtins.readFile "${betterfox}/Peskyfox.js")
          (builtins.readFile "${betterfox}/Securefox.js")

          # [Fastfox.js](https://github.com/yokoffing/Betterfox/blob/main/Fastfox.js) overrides
          # GFX RENDERING TWEAKS
          ''user_pref("gfx.webrender.all", true);''

          # [Peskyfox.js](https://github.com/yokoffing/Betterfox/blob/main/Peskyfox.js) overrides
          # DOWNLOADS
          ''user_pref("browser.download.alwaysOpenPanel", false);'' # disable download panel opening on every downloadj

          # [Securefox.js](https://github.com/yokoffing/Betterfox/blob/main/Securefox.js) overrides
          # TRACKING PROTECTION
          ''user_pref("privacy.donottrackheader.enabled", true);''
          ''user_pref("privacy.trackingprotection.enabled", true);''
          ''user_pref("privacy.trackingprotection.socialtracking.enabled", true);''
          ''user_pref("beacon.enabled", false);'' # No bluetooth location BS in my webbrowser please
          ''user_pref("dom.battery.enabled", false);'' # you don't need to see my battery...
          # CONTAINERS
          ''user_pref("privacy.userContext.enabled", true);''
          # PASSWORDS
          ''user_pref("browser.contentblocking.report.lockwise.enabled", false);'' # don't use firefox password manger
          # ADDRESS + CREDIT CARD MANAGER
          ''user_pref("extensions.formautofill.creditCards.enabled", false);'' # don't auto-fill credit card information
          # MOZILLA
          ''user_pref("identity.fxaccounts.enabled", true);'' # eanble Firefox Sync
          ''user_pref("webchannel.allowObject.urlWhitelist", "https://content.cdn.mozilla.net https://install.mozilla.org https://accounts.firefox.com");'' # fix for cannot sign in to firefox sync account
          ''user_pref("dom.push.enabled", false);'' # no notifications, really...
          # TELEMETRY
          ''user_pref("extensions.webcompat-reporter.enabled", false);'' # don't report compability problems to mozilla
          ''user_pref("browser.urlbar.eventTelemetry.enabled", false);'' # (default)
          # PLUGINS
          ''user_pref("browser.eme.ui.enabled", false);''
          ''user_pref("media.eme.enabled", false);''
          # DETECTION
          ''user_pref("extensions.abuseReport.enabled", false);'' # don't show 'report abuse' in extensions
        ];

        #userChrome = ''
        #  /* Completely hide tabs */
        #  #TabsToolbar { visibility: collapse; }
        #'';

        extensions = with pkgs.nur.repos.rycee.firefox-addons; [
          # https://nur.nix-community.org/repos/rycee/
          cookie-autodelete
          darkreader
          decentraleyes
          enhancer-for-youtube
          i-dont-care-about-cookies
          clearurls # alternative: link-cleaner
          noscript
          onepassword-password-manager
          privacy-badger
          return-youtube-dislikes
          sidebery
          sponsorblock
          to-deepl
          ublock-origin
          undoclosetabbutton
          user-agent-string-switcher
          youtube-recommended-videos
        ];

        search = {
          force = true;
          default = "Searx";
          order = [ "DuckDuckGo" "Searx" "Kagi" "Youtube" "NixOS Options" "Nix Packages" "Home Manager" "GitHub" "HackerNews" ];

          engines = {
            "Bing".metaData.hidden = true;
            "Google".metaData.hidden = true;
            #"Amazon.com".metaData.hidden = true;

            "Searx" = {
              #NOTE This is a local server!
              iconUpdateURL = "https://searx.schallernetz.lan/favicon.ico";
              definedAliases = [ "@searx" "@sx" ];
              urls = [{
                template = "https://searx.schallernetz.lan/search";
                params = [{
                  name = "q";
                  value = "{searchTerms}";
                }];
              }];
            };
            "Kagi" = {
              iconUpdateURL = "https://kagi.com/favicon.ico";
              updateInterval = 24 * 60 * 60 * 1000;
              definedAliases = [ "@kagi" "@k" ];
              urls = [{
                template = "https://kagi.com/search";
                params = [{
                  name = "q";
                  value = "{searchTerms}";
                }];
              }];
            };
            "YouTube" = {
              iconUpdateURL = "https://youtube.com/favicon.ico";
              updateInterval = 24 * 60 * 60 * 1000;
              definedAliases = [ "@youtube" "@yt" ];
              urls = [{
                template = "https://www.youtube.com/results";
                params = [{
                  name = "search_query";
                  value = "{searchTerms}";
                }];
              }];
            };
            "Nix Packages" = {
              icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
              definedAliases = [ "@nix-pagages" "@nixpkgs" "@np" ];
              urls = [{
                template = "https://search.nixos.org/packages";
                params = [
                  {
                    name = "type";
                    value = "packages";
                  }
                  {
                    name = "query";
                    value = "{searchTerms}";
                  }
                ];
              }];
            };
            "NixOS Options" = {
              icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
              definedAliases = [ "@nixos-options" "@nixosopt" "@no" ];
              urls = [{
                template = "https://search.nixos.org/options";
                params = [
                  {
                    name = "channel";
                    value = "${osConfig.system.stateVersion or config.home.stateVersion or "unstable"}";
                  }
                  {
                    name = "query";
                    value = "{searchTerms}";
                  }
                ];
              }];
            };
            "Home Manager" = {
              icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
              definedAliases = [ "@home-manager" "@hm" ];
              urls = [{
                template = "https://home-manager-options.extranix.com/";
                params = [
                  {
                    name = "release";
                    value = "release-${config.home.stateVersion}";
                  }
                  {
                    name = "query";
                    value = "{searchTerms}";
                  }
                ];
              }];
            };
            "GitHub" = {
              iconUpdateURL = "https://github.com/favicon.ico";
              updateInterval = 24 * 60 * 60 * 1000;
              definedAliases = [ "@github" "@gh" ];
              urls = [{
                template = "https://github.com/search";
                params = [{
                  name = "q";
                  value = "{searchTerms}";
                }];
              }];
            };
            "HackerNews" = {
              iconUpdateURL = "https://hn.algolia.com/favicon.ico";
              updateInterval = 24 * 60 * 60 * 1000;
              definedAliases = [ "@hackernews" "@hn" ];
              urls = [{
                template = "https://hn.algolia.com/";
                params = [{
                  name = "query";
                  value = "{searchTerms}";
                }];
              }];
            };
          };
        };
      };
    };

    xdg.mimeApps.defaultApplications = mkIf
      cfg.defaultApplication
      (listToAttrs (map (mimeType: { name = mimeType; value = [ "firefox.desktop" ]; }) [
        "application/x-extension-htm"
        "application/x-extension-html"
        "application/x-extension-shtml"
        "application/x-extension-xht"
        "application/x-extension-xhtml"
        "application/xhtml+xml"
        "x-scheme-handler/about"
        "x-scheme-handler/ftp"
        "x-scheme-handler/http"
        "x-scheme-handler/https"
        "x-scheme-handler/unknown"
        #"application/json"
        #"application/pdf"
        #"text/html"
        #"text/xml"
      ]));

    wayland.windowManager.hyprland.settings = {
      exec-once = mkIf cfg.autostart [ "[workspace 1 silent] ${getExe config.programs.firefox.package}" ];
      windowrulev2 = [
        "idleinhibit fullscreen, class:firefox, title:(Youtube)"
        "float, class:librewolf, title:^Extension: \(NoScript\) - NoScript XSS Warning — LibreWolf$"
      ];
    };
  };
}
