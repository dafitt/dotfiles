{ options, config, lib, pkgs, ... }:

with lib;
with lib.custom;
let
  cfg = config.custom.web.librewolf;
in
{
  options.custom.web.librewolf = with types; {
    enable = mkBoolOpt config.custom.web.enableSuite "Enable the librewolf web browser";
    defaultApplication = mkBoolOpt false "Set librewolf as the default application for its mimetypes";
  };

  config = mkIf cfg.enable {
    # a fork of Firefox, focused on privacy, security and freedom
    # https://librewolf.net/
    programs.librewolf = {
      enable = true;

      settings = {
        # [detailed settings](https://searchfox.org/mozilla-release/source/browser/app/profile/firefox.js)

        "browser.tabs.insertAfterCurrent" = true;
        "browser.urlbar.shortcuts.quickactions" = true;
        "general.autoScroll" = true;
        #"widget.use-xdg-desktop-portal.file-picker" = true;

        # Sync
        "identity.fxaccounts.enabled" = true;
        "services.sync.prefs.sync.browser.uiCustomization.state" = true; # sync customized toolbar settings
        "browser.uiCustomization.state" = ''
          {"placements":{"widget-overflow-fixed-list":[],"unified-extensions-area":["sponsorblocker_ajay_app-browser-action","_7b1bf0b6-a1b9-42b0-b75d-252036438bdc_-browser-action","_605a075b-09d9-4443-bed6-4baa743f7d79_-browser-action","myallychou_gmail_com-browser-action","cookieautodelete_kennydo_com-browser-action","jid1-kkzogwgsw3ao4q_jetpack-browser-action","_74145f27-f039-47ce-a470-a662b129930a_-browser-action","_94249bf3-29a3-4bb5-aa30-013883e8f2f4_-browser-action","_2cf5dbed-78fe-4bd5-9524-38fdf837be98_-browser-action","_ab0ae774-f22f-479b-9b1b-6aff11bf6f5c_-browser-action","_b9acf540-acba-11e1-8ccb-001fd0e08bd4_-browser-action","_34daeb50-c2d2-4f14-886a-7160b24d66a4_-browser-action"],"nav-bar":["simple-tab-groups_drive4ik-browser-action","back-button","forward-button","stop-reload-button","customizableui-special-spring1","addon_darkreader_org-browser-action","ublock0_raymondhill_net-browser-action","_73a6fe31-595d-460b-a920-fcc0f8843232_-browser-action","urlbar-container","_4853d046-c5a3-436b-bc36-220fd935ee1d_-browser-action","history-panelmenu","screenshot-button","downloads-button","customizableui-special-spring2","_d634138d-c276-4fc8-924b-40a0ea21d284_-browser-action","fxa-toolbar-menu-button","unified-extensions-button","reset-pbm-toolbar-button","_a6c4a591-f1b2-4f03-b3ff-767e5bedf4e7_-browser-action"],"toolbar-menubar":["menubar-items"],"TabsToolbar":["firefox-view-button","tabbrowser-tabs","new-tab-button","alltabs-button"],"PersonalToolbar":["personal-bookmarks"]},"seen":["save-to-pocket-button","developer-button","_a6c4a591-f1b2-4f03-b3ff-767e5bedf4e7_-browser-action","sponsorblocker_ajay_app-browser-action","_7b1bf0b6-a1b9-42b0-b75d-252036438bdc_-browser-action","_73a6fe31-595d-460b-a920-fcc0f8843232_-browser-action","_605a075b-09d9-4443-bed6-4baa743f7d79_-browser-action","myallychou_gmail_com-browser-action","cookieautodelete_kennydo_com-browser-action","jid1-kkzogwgsw3ao4q_jetpack-browser-action","simple-tab-groups_drive4ik-browser-action","_4853d046-c5a3-436b-bc36-220fd935ee1d_-browser-action","_d634138d-c276-4fc8-924b-40a0ea21d284_-browser-action","ublock0_raymondhill_net-browser-action","addon_darkreader_org-browser-action","_74145f27-f039-47ce-a470-a662b129930a_-browser-action","_94249bf3-29a3-4bb5-aa30-013883e8f2f4_-browser-action","_2cf5dbed-78fe-4bd5-9524-38fdf837be98_-browser-action","_ab0ae774-f22f-479b-9b1b-6aff11bf6f5c_-browser-action","_b9acf540-acba-11e1-8ccb-001fd0e08bd4_-browser-action","_34daeb50-c2d2-4f14-886a-7160b24d66a4_-browser-action"],"dirtyAreaCache":["nav-bar","PersonalToolbar","toolbar-menubar","TabsToolbar","unified-extensions-area"],"currentVersion":20,"newElementCount":8}
        '';
        "noscript.sync.enabled" = true;

        # Dark Theme
        "devtools.theme" = "dark";
        "extensions.activeThemeID" = "firefox-compact-dark@mozilla.org"; # browser dark theme
        "layout.css.prefers-color-scheme.content-override" = 0; # set default perefered color scheme to dark
        "svg.context-properties.content.enabled" = true; # fully support the dark theme

        # Resore last Session
        "browser.startup.page" = 3;
        "places.history.enabled" = true;
        "privacy.clearOnShutdown.history" = false;
        # Do not check if Librewolf is the default browser
        "browser.shell.checkDefaultBrowser" = false;
        # Don't use the built-in password manager
        "signon.rememberSignons" = false;
        "signon.generation.enabled" = false;
        # Disable the "new tab page" feature and show a blank tab instead
        # https://wiki.mozilla.org/Privacy/Reviews/New_Tab
        # https://support.mozilla.org/en-US/kb/new-tab-page-show-hide-and-customize-top-sites#w_how-do-i-turn-the-new-tab-page-off
        "browser.newtabpage.enabled" = false;
        "browser.newtab.url" = "about:blank";
        # Disable Activity Stream
        # https://wiki.mozilla.org/Librewolf/Activity_Stream
        "browser.newtabpage.activity-stream.enabled" = false;
        "browser.newtabpage.activity-stream.telemetry" = false;
        # Disable new tab tile ads & preload
        # http://www.thewindowsclub.com/disable-remove-ad-tiles-from-firefox
        # http://forums.mozillazine.org/viewtopic.php?p=13876331#p13876331
        # https://wiki.mozilla.org/Tiles/Technical_Documentation#Ping
        # https://gecko.readthedocs.org/en/latest/browser/browser/DirectoryLinksProvider.html#browser-newtabpage-directory-source
        # https://gecko.readthedocs.org/en/latest/browser/browser/DirectoryLinksProvider.html#browser-newtabpage-directory-ping
        "browser.newtabpage.enhanced" = false;
        "browser.newtabpage.introShown" = true;
        "browser.newtab.preload" = false;
        "browser.newtabpage.directory.ping" = "";
        "browser.newtabpage.directory.source" = "data:text/plain,{}";
        # Reduce search engine noise in the urlbar's completion window. The
        # shortcuts and suggestions will still work, but Librewolf won't clutter
        # its UI with reminders that they exist.
        "browser.urlbar.suggest.searches" = false;
        "browser.urlbar.shortcuts.bookmarks" = false;
        "browser.urlbar.shortcuts.history" = false;
        "browser.urlbar.shortcuts.tabs" = false;
        "browser.urlbar.showSearchSuggestionsFirst" = false;
        "browser.urlbar.speculativeConnect.enabled" = false;
        # https://bugzilla.mozilla.org/1642623
        "browser.urlbar.dnsResolveSingleWordsAfterSearch" = 0;
        # https://blog.mozilla.org/data/2021/09/15/data-and-firefox-suggest/
        "browser.urlbar.suggest.quicksuggest.nonsponsored" = false;
        "browser.urlbar.suggest.quicksuggest.sponsored" = false;
        # Show whole URL in address bar
        "browser.urlbar.trimURLs" = false;
        # Disable some not so useful functionality.
        "browser.disableResetPrompt" = true; # "Looks like you haven't started Librewolf in a while."
        "browser.onboarding.enabled" = false; # "New to Librewolf? Let's get started!" tour
        "browser.aboutConfig.showWarning" = false; # Warning when opening about:config
        "media.videocontrols.picture-in-picture.video-toggle.enabled" = false;
        "extensions.pocket.enabled" = false;
        "extensions.shield-recipe-client.enabled" = false;
        "reader.parse-on-load.enabled" = false; # "reader view"
        # Disable Form autofill
        # https://wiki.mozilla.org/Firefox/Features/Form_Autofill
        "browser.formfill.enable" = false;
        "extensions.formautofill.addresses.enabled" = false;
        "extensions.formautofill.available" = "off";
        "extensions.formautofill.creditCards.available" = false;
        "extensions.formautofill.creditCards.enabled" = false;
        "extensions.formautofill.heuristics.enabled" = false;
        # Disable first run intro
        "app.normandy.first_run" = false;
        # Disable middle click paste
        "middlemouse.paste" = false;

        # [Betterfox](https://github.com/yokoffing/Betterfox/blob/main/librewolf.overrides.cfg)

        # Fastfox
        "dom.enable_web_task_scheduling" = true;
        "layout.css.grid-template-masonry-value.enabled" = true;
        "layout.css.animation-composition.enabled" = true;
        "network.dns.disablePrefetch" = true;
        "network.prefetch-next" = false;

        # Peskyfox
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

        # Securefox
        "privacy.trackingprotection.emailtracking.enabled" = true;
        "urlclassifier.trackingSkipURLs" = "*.reddit.com, *.twitter.com, *.twimg.com";
        "urlclassifier.features.socialtracking.skipURLs" = "*.instagram.com, *.twitter.com, *.twimg.com";
        "security.OCSP.enabled" = 0;
        "security.OCSP.require" = false;
        "privacy.resistFingerprinting" = false; # problems firefox sync login
        "webgl.disabled" = false;
        "media.eme.enabled" = true;
        "dom.security.https_only_mode_error_page_user_suggestions" = true;
        "media.peerconnection.ice.no_host" = false;
        "permissions.default.geo" = 2;
        "permissions.default.desktop-notification" = 2;
        # Chose with what to open new file types
        "browser.download.always_ask_before_handling_new_types" = true;
        # Security-oriented defaults
        "security.family_safety.mode" = 0;
        # https://blog.mozilla.org/security/2016/10/18/phasing-out-sha-1-on-the-public-web/
        "security.pki.sha1_enforcement_level" = 1;
        # https://github.com/tlswg/tls13-spec/issues/1001
        "security.tls.enable_0rtt_data" = false;
        # Use Mozilla geolocation service instead of Google if given permission
        "geo.provider.network.url" = "https://location.services.mozilla.com/v1/geolocate?key=%MOZILLA_API_KEY%";
        "geo.provider.use_gpsd" = false;
        # https://support.mozilla.org/en-US/kb/extension-recommendations
        "browser.newtabpage.activity-stream.asrouter.userprefs.cfr" = false;
        "browser.newtabpage.activity-stream.asrouter.userprefs.cfr.addons" = false;
        "browser.newtabpage.activity-stream.asrouter.userprefs.cfr.features" = false;
        "extensions.htmlaboutaddons.recommendations.enabled" = false;
        "extensions.htmlaboutaddons.discover.enabled" = false;
        "extensions.getAddons.showPane" = false; # uses Google Analytics
        "browser.discovery.enabled" = false;
        # Disable battery API
        # https://developer.mozilla.org/en-US/docs/Web/API/BatteryManager
        # https://bugzilla.mozilla.org/show_bug.cgi?id=1313580
        "dom.battery.enabled" = false;
        # Disable "beacon" asynchronous HTTP transfers (used for analytics)
        # https://developer.mozilla.org/en-US/docs/Web/API/navigator.sendBeacon
        "beacon.enabled" = false;
        # Disable pinging URIs specified in HTML <a> ping= attributes
        # http://kb.mozillazine.org/Browser.send_pings
        "browser.send_pings" = false;
        # Disable gamepad API to prevent USB device enumeration
        # https://www.w3.org/TR/gamepad/
        # https://trac.torproject.org/projects/tor/ticket/13023
        "dom.gamepad.enabled" = false;
        # Don't try to guess domain names when entering an invalid domain name in URL bar
        # http://www-archive.mozilla.org/docs/end-user/domain-guessing.html
        "browser.fixup.alternate.enabled" = false;
        # Disable telemetry
        # https://wiki.mozilla.org/Platform/Features/Telemetry
        # https://wiki.mozilla.org/Privacy/Reviews/Telemetry
        # https://wiki.mozilla.org/Telemetry
        # https://www.mozilla.org/en-US/legal/privacy/firefox.html#telemetry
        # https://support.mozilla.org/t5/Firefox-crashes/Mozilla-Crash-Reporter/ta-p/1715
        # https://wiki.mozilla.org/Security/Reviews/Firefox6/ReviewNotes/telemetry
        # https://gecko.readthedocs.io/en/latest/browser/experiments/experiments/manifest.html
        # https://wiki.mozilla.org/Telemetry/Experiments
        # https://support.mozilla.org/en-US/questions/1197144
        # https://firefox-source-docs.mozilla.org/toolkit/components/telemetry/telemetry/internals/preferences.html#id1
        "toolkit.telemetry.unified" = false;
        "toolkit.telemetry.enabled" = false;
        "toolkit.telemetry.server" = "data:,";
        "toolkit.telemetry.archive.enabled" = false;
        "toolkit.telemetry.coverage.opt-out" = true;
        "toolkit.coverage.opt-out" = true;
        "toolkit.coverage.endpoint.base" = "";
        "experiments.supported" = false;
        "experiments.enabled" = false;
        "experiments.manifest.uri" = "";
        "browser.ping-centre.telemetry" = false;
        # https://mozilla.github.io/normandy/
        "app.normandy.enabled" = false;
        "app.normandy.api_url" = "";
        "app.shield.optoutstudies.enabled" = false;
        # Disable health reports (basically more telemetry)
        # https://support.mozilla.org/en-US/kb/firefox-health-report-understand-your-browser-perf
        # https://gecko.readthedocs.org/en/latest/toolkit/components/telemetry/telemetry/preferences.html
        "datareporting.healthreport.uploadEnabled" = false;
        "datareporting.healthreport.service.enabled" = false;
        "datareporting.policy.dataSubmissionEnabled" = false;
        # Disable proxy
        "network.proxy.type" = 0;
        # Don't allow websites to mess with context menu
        "dom.event.contextmenu.enabled" = false;
        # Mitigate fingerprinting
        #"media.peerconnection.enabled " = false;
        #"geo.enabled" = false;
        #"privacy.firstparty.isolate" = true;
        #"media.navigator.enabled" = false; # this block websites from getting your camera and mic status
        # Disable crash reports
        "breakpad.reportURL" = "";
        "browser.tabs.crashReporting.sendReport" = false;
        "browser.crashReports.unsubmittedCheck.autoSubmit2" = false; # don't submit backlogged reports
        # Other privacy focused settings
        "accessibility.force_disabled" = 1;
        "accessibility.typeaheadfind.flashBar" = 0;
        "browser.search.suggest.enabled" = true;
        "browser.search.update" = false;
        "privacy.trackingprotection.enabled" = true;
        "privacy.trackingprotection.socialtracking.enabled" = true;
        "privacy.history.custom" = true;
        "privacy.cpd.history" = true;
        "dom.security.https_only_mode" = true;
        "dom.security.https_only_mode_ever_enabled" = true;
        "dom.event.clipboardevents.enabled" = false;
        "dom.push.enabled" = false; # I don't even know why you would want this.
        "browser.safebrowsing.phishing.enabled" = false;
        "browser.safebrowsing.malware.enabled" = false;
        "security.pki.crlite_mode" = 2; # advance ssl certificate check
        "privacy.clearOnShutdown.cache" = true; # clear cache on shutdown
        "privacy.clearOnShutdown.downloads" = true;
        "privacy.clearOnShutdown.formdata" = true;
        "privacy.clearOnShutdown.cookies" = false; # don't clear so we stay logged in
        "privacy.clearOnShutdown.offlineApps" = false; # don't clear so we stay logged in
      };
    };

    xdg.mimeApps.defaultApplications = mkIf cfg.defaultApplication (listToAttrs (map (mimeType: { name = mimeType; value = [ "librewolf.desktop" ]; }) [
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
      exec-once = [ "[workspace 1 silent] ${config.programs.librewolf.package}/bin/librewolf" ];
      windowrulev2 = [
        "idleinhibit fullscreen, class:librewolf, title:(Youtube)"
      ];
    };
  };
}
