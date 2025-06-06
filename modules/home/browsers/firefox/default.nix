{ config, lib, pkgs, host, osConfig ? { }, ... }:

with lib;
with lib.dafitt;
let
  cfg = config.dafitt.browsers.firefox;

  betterfox = pkgs.fetchFromGitHub {
    owner = "yokoffing";
    repo = "Betterfox";
    rev = "137.0"; # https://github.com/yokoffing/Betterfox/tags
    hash = "sha256-oK8nP7mZ8Q6TNgCY/E7D5E28e7qaBHfE4tbdus7vusU=";
  };
in
{
  options.dafitt.browsers.firefox = with types; {
    enable = mkEnableOption "browser 'firefox'";

    autostart = mkBoolOpt false "Whether to autostart at user login."; # disabled because of sideberry plugin
    configureKeybindings = mkBoolOpt false "Whether to configure keybindings.";
    workspace = mkOpt int 1 "Which workspace is mainly to be used for this application.";
  };

  config = mkIf cfg.enable {
    dafitt.stylix.enable = true;
    stylix.targets.firefox.profileNames = [ config.home.username ];

    programs.firefox = {
      enable = true;
      profiles.${config.home.username} = {
        name = config.home.username;
        id = 0;
        isDefault = true;
        settings = {
          #
          # General / personal settings
          #
          "browser.tabs.insertAfterCurrent" = true;
          "browser.urlbar.trimURLs" = false; # show whole URL in address bar
          "general.autoScroll" = true; # enable middle-click scrolling
          "toolkit.legacyUserProfileCustomizations.stylesheets" = true; # enable userChrome customisations
          "ui.textSelectBackgroundAttention" = "${config.lib.stylix.colors.withHashtag.base00}";

          # ui arrangement
          "browser.uiCustomization.state" = ''
            {"placements":{"widget-overflow-fixed-list":[],"unified-extensions-area":["jid1-mnnxcxisbpnsxq_jetpack-browser-action","sponsorblocker_ajay_app-browser-action","_7b1bf0b6-a1b9-42b0-b75d-252036438bdc_-browser-action","_605a075b-09d9-4443-bed6-4baa743f7d79_-browser-action","myallychou_gmail_com-browser-action","cookieautodelete_kennydo_com-browser-action","jid1-kkzogwgsw3ao4q_jetpack-browser-action","_74145f27-f039-47ce-a470-a662b129930a_-browser-action","_94249bf3-29a3-4bb5-aa30-013883e8f2f4_-browser-action","_2cf5dbed-78fe-4bd5-9524-38fdf837be98_-browser-action","_ab0ae774-f22f-479b-9b1b-6aff11bf6f5c_-browser-action","_b9acf540-acba-11e1-8ccb-001fd0e08bd4_-browser-action","_34daeb50-c2d2-4f14-886a-7160b24d66a4_-browser-action","jid1-bofifl9vbdl2zq_jetpack-browser-action","_85860b32-02a8-431a-b2b1-40fbd64c9c69_-browser-action","addon_fastforward_team-browser-action","enhancerforyoutube_maximerf_addons_mozilla_org-browser-action","switchyomega_feliscatus_addons_mozilla_org-browser-action","user-agent-switcher_ninetailed_ninja-browser-action","_762f9885-5a13-4abd-9c77-433dcd38b8fd_-browser-action","_aecec67f-0d10-4fa7-b7c7-609a2db280cf_-browser-action","_b86e4813-687a-43e6-ab65-0bde4ab75758_-browser-action"],"nav-bar":["simple-tab-groups_drive4ik-browser-action","_3c078156-979c-498b-8990-85f7987dd929_-browser-action","back-button","forward-button","stop-reload-button","customizableui-special-spring1","addon_darkreader_org-browser-action","ublock0_raymondhill_net-browser-action","_73a6fe31-595d-460b-a920-fcc0f8843232_-browser-action","urlbar-container","_4853d046-c5a3-436b-bc36-220fd935ee1d_-browser-action","history-panelmenu","screenshot-button","downloads-button","customizableui-special-spring2","_d634138d-c276-4fc8-924b-40a0ea21d284_-browser-action","_446900e4-71c2-419f-a6a7-df9c091e268b_-browser-action","fxa-toolbar-menu-button","unified-extensions-button","reset-pbm-toolbar-button","_a6c4a591-f1b2-4f03-b3ff-767e5bedf4e7_-browser-action"],"toolbar-menubar":["menubar-items"],"TabsToolbar":["firefox-view-button","tabbrowser-tabs","new-tab-button","alltabs-button"],"PersonalToolbar":["personal-bookmarks"]},"seen":["save-to-pocket-button","developer-button","_a6c4a591-f1b2-4f03-b3ff-767e5bedf4e7_-browser-action","sponsorblocker_ajay_app-browser-action","_7b1bf0b6-a1b9-42b0-b75d-252036438bdc_-browser-action","_73a6fe31-595d-460b-a920-fcc0f8843232_-browser-action","_605a075b-09d9-4443-bed6-4baa743f7d79_-browser-action","myallychou_gmail_com-browser-action","cookieautodelete_kennydo_com-browser-action","jid1-kkzogwgsw3ao4q_jetpack-browser-action","simple-tab-groups_drive4ik-browser-action","_4853d046-c5a3-436b-bc36-220fd935ee1d_-browser-action","_d634138d-c276-4fc8-924b-40a0ea21d284_-browser-action","ublock0_raymondhill_net-browser-action","addon_darkreader_org-browser-action","_74145f27-f039-47ce-a470-a662b129930a_-browser-action","_94249bf3-29a3-4bb5-aa30-013883e8f2f4_-browser-action","_2cf5dbed-78fe-4bd5-9524-38fdf837be98_-browser-action","_ab0ae774-f22f-479b-9b1b-6aff11bf6f5c_-browser-action","_b9acf540-acba-11e1-8ccb-001fd0e08bd4_-browser-action","_34daeb50-c2d2-4f14-886a-7160b24d66a4_-browser-action","jid1-mnnxcxisbpnsxq_jetpack-browser-action","_3c078156-979c-498b-8990-85f7987dd929_-browser-action","jid1-bofifl9vbdl2zq_jetpack-browser-action","_85860b32-02a8-431a-b2b1-40fbd64c9c69_-browser-action","addon_fastforward_team-browser-action","enhancerforyoutube_maximerf_addons_mozilla_org-browser-action","switchyomega_feliscatus_addons_mozilla_org-browser-action","user-agent-switcher_ninetailed_ninja-browser-action","_446900e4-71c2-419f-a6a7-df9c091e268b_-browser-action","_762f9885-5a13-4abd-9c77-433dcd38b8fd_-browser-action","_aecec67f-0d10-4fa7-b7c7-609a2db280cf_-browser-action","_b86e4813-687a-43e6-ab65-0bde4ab75758_-browser-action"],"dirtyAreaCache":["nav-bar","PersonalToolbar","toolbar-menubar","TabsToolbar","unified-extensions-area"],"currentVersion":20,"newElementCount":10}
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
          "extensions.shield-recipe-client.enabled" = false;
          "middlemouse.paste" = false; # disable middle click paste
          "dom.push.connection.enabled" = false;
          "device.sensors.enabled" = false; # This isn't a phone

          # disable the "new tab page" feature and show a blank tab instead
          "browser.newtabpage.enabled" = false;
          "browser.newtabpage.activity-stream.showSponsored" = false;
          "browser.newtabpage.activity-stream.showSponsoredTopSites" = false;
          "browser.newtab.url" = "about:blank";

          # Extensions are managed with Nix, so don't update.
          "extensions.update.enabled" = false;
        };

        extraConfig = builtins.concatStringsSep "\n" [
          #
          # [Betterfox](https://github.com/yokoffing/Betterfox)
          #
          (builtins.readFile "${betterfox}/Fastfox.js")
          (builtins.readFile "${betterfox}/Peskyfox.js")
          (builtins.readFile "${betterfox}/Securefox.js")

          # Additional settings #
          # [Fastfox.js](https://github.com/yokoffing/Betterfox/blob/main/Fastfox.js) overrides
          # GFX RENDERING TWEAKS
          ''user_pref("gfx.webrender.all", true);''
          # [Peskyfox.js](https://github.com/yokoffing/Betterfox/blob/main/Peskyfox.js) overrides
          # DOWNLOADS
          ''user_pref("browser.download.useDownloadDir", true);'' # dont ask where to download
          ''user_pref("browser.download.alwaysOpenPanel", false);'' # disable download panel opening on every download
          # TAB BEHAVIOR
          ''user_pref("browser.link.open_newwindow.restriction", 0);''
          # UNCATEGORIZED
          ''user_pref("browser.backspace_action", 0);''
          # [Securefox.js](https://github.com/yokoffing/Betterfox/blob/main/Securefox.js) overrides
          # CONTAINERS
          ''user_pref("privacy.userContext.enabled", true);''
          # MOZILLA
          ''user_pref("webchannel.allowObject.urlWhitelist", "https://content.cdn.mozilla.net https://install.mozilla.org https://accounts.firefox.com");'' # fix for cannot sign in to firefox sync account
          ''user_pref("dom.push.enabled", false);'' # no notifications, really...

          # Optional Hardening #
          # https://github.com/yokoffing/Betterfox/wiki/Optional-Hardening#password-credit-card-and-address-management
          # Password, credit card, and address management
          ''user_pref("signon.rememberSignons", false);''
          ''user_pref("extensions.formautofill.addresses.enabled", false);''
          ''user_pref("extensions.formautofill.creditCards.enabled", false);''
          # Block embedded social posts on webpages
          ''user_pref("urlclassifier.trackingSkipURLs", "");''
          ''user_pref("urlclassifier.features.socialtracking.skipURLs", "");''
        ];

        userChrome = ''
          /* hide tabs title bar, if a sidebar is used */
          #main-window[titlepreface*="Vtabs"] #TabsToolbar { visibility: collapse; }
          #main-window[titlepreface*="Vtabs"] #sidebar-header { display: none; }
        '';

        extensions.packages = with pkgs.nur.repos.rycee.firefox-addons; [
          # https://nur.nix-community.org/repos/rycee/
          # privacy and convenience
          clearurls # alternative: link-cleaner
          cookie-autodelete
          darkreader
          fastforwardteam
          i-dont-care-about-cookies
          localcdn
          privacy-badger
          sidebery
          sponsorblock
          switchyomega
          ublock-origin
          undoclosetabbutton
          user-agent-string-switcher
          violentmonkey
        ];

        search = {
          force = true;
          default = "ddg";
          order = [ "ddg" "searx" "kagi" "youtube" "nix-packages" "nixos-options" "home-manager" "github" "hackernews" ];

          engines = {
            "bing".metaData.hidden = true;
            "ddg".metaData.alias = "@d";
            "google".metaData.hidden = true;

            "searx" = {
              name = "Searx";
              icon = "https://searx.schallernetz.de/favicon.ico";
              definedAliases = [ "@searx" "@sx" "@s" ];
              urls = [{
                template = "https://searx.schallernetz.de/search";
                params = [{ name = "q"; value = "{searchTerms}"; }];
              }];
            };
            "kagi" = {
              name = "Kagi";
              icon = "https://kagi.com/favicon.ico";
              definedAliases = [ "@kagi" "@kg" ];
              urls = [{
                template = "https://kagi.com/search";
                params = [{ name = "q"; value = "{searchTerms}"; }];
              }];
            };
            "youtube" = {
              icon = "https://youtube.com/favicon.ico";
              definedAliases = [ "@youtube" "@yt" ];
              urls = [{
                template = "https://www.youtube.com/results";
                params = [{ name = "search_query"; value = "{searchTerms}"; }];
              }];
            };
            "nix-packages" = {
              name = "Nix Packages";
              definedAliases = [ "@nix-packages" "@nixpkgs" "@np" ];
              urls = [{
                template = "https://search.nixos.org/packages";
                params = [
                  { name = "type"; value = "packages"; }
                  { name = "query"; value = "{searchTerms}"; }
                ];
              }];
              icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
            };
            "nixos-wiki" = {
              name = "NixOS Wiki";
              definedAliases = [ "@nixos-wiki" "@nixoswiki" "@nw" ];
              urls = [{ template = "https://wiki.nixos.org/w/index.php?search={searchTerms}"; }];
              icon = "https://wiki.nixos.org/favicon.ico";
            };
            "nixos-options" = {
              name = "NixOS Options";
              definedAliases = [ "@nixos-options" "@nixosopt" "@no" ];
              urls = [{
                template = "https://search.nixos.org/options";
                params = [
                  { name = "channel"; value = "${osConfig.system.stateVersion or config.home.stateVersion or "unstable"}"; }
                  { name = "query"; value = "{searchTerms}"; }
                ];
              }];
              icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
            };
            "home-manager-options" = {
              name = "Home Manager Options";
              definedAliases = [ "@home-manager-options" "@hmopt" "@hm" "@ho" ];
              urls = [{
                template = "https://home-manager-options.extranix.com/";
                params = [
                  { name = "release"; value = "release-${config.home.stateVersion}"; }
                  { name = "query"; value = "{searchTerms}"; }
                ];
              }];
              icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
            };
            "github" = {
              name = "GitHub";
              definedAliases = [ "@github" "@gh" ];
              urls = [{
                template = "https://github.com/search";
                params = [{ name = "q"; value = "{searchTerms}"; }];
              }];
              icon = "https://github.com/favicon.ico";
            };
            "hackernews" = {
              name = "Hacker News";
              definedAliases = [ "@hackernews" "@hn" ];
              urls = [{
                template = "https://hn.algolia.com/";
                params = [{ name = "query"; value = "{searchTerms}"; }];
              }];
              icon = "https://hn.algolia.com/favicon.ico";
            };
          };
        };
      };
    };

    wayland.windowManager.hyprland.settings = {
      bind = mkIf cfg.configureKeybindings [ "SUPER_ALT, W, exec, uwsm app -- ${getExe config.programs.firefox.package}" ];
      exec-once = mkIf cfg.autostart [ "[workspace ${toString cfg.workspace} silent] uwsm app -- ${getExe config.programs.firefox.package}" ];
      windowrule = [
        "idleinhibit fullscreen, class:firefox, title:(Youtube)"
        "float, class:firefox, title:^Extension: \(NoScript\) - NoScript"
      ];
    };

    # needs inputs.xdg-autostart.homeManagerModules.xdg-autostart
    xdg.autoStart.packages = mkIf cfg.autostart [ config.programs.firefox.package ];
  };
}
