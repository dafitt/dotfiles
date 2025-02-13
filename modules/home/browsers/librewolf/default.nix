{ options, config, lib, pkgs, ... }:

with lib;
with lib.dafitt;
let
  cfg = config.dafitt.browsers.librewolf;
in
{
  options.dafitt.browsers.librewolf = with types; {
    enable = mkEnableOption "browser 'librewolf'";

    autostart = mkBoolOpt false "Whether to autostart at user login.";
    configureKeybindings = mkBoolOpt false "Whether to configure keybindings.";
    workspace = mkOpt int 1 "Which workspace is mainly to be used for this application.";
  };

  config = mkIf cfg.enable {
    # a fork of Firefox, focused on privacy, security and freedom
    # https://librewolf.net/
    programs.librewolf = {
      enable = true;
      settings = config.programs.firefox.profiles.${config.home.username}.settings // {

        # [Betterfox](https://github.com/yokoffing/Betterfox/blob/main/librewolf.overrides.cfg)

        /****************************************************************************
         * Betterfox - LibreWolf overrides                                          *
         * Quis custodiet ipsos custodes                                            *
         * version: August 2023                                                     *
         * url: https://github.com/yokoffing/Betterfox                              *
         * license: https://github.com/yokoffing/Betterfox/blob/main/LICENSE        *
         * README: https://github.com/yokoffing/Betterfox/blob/main/README.md       *
        ****************************************************************************/

        /****************************************************************************
         * SECTION: FASTFOX                                                         *
        ****************************************************************************/
        "layout.css.grid-template-masonry-value.enabled" = true;
        "dom.enable_web_task_scheduling" = true;

        /****************************************************************************
         * SECTION: SECUREFOX                                                       *
        ****************************************************************************/
        /** TRACKING PROTECTION ***/
        "urlclassifier.trackingSkipURLs" = "*.reddit.com, *.twitter.com, *.twimg.com";
        "urlclassifier.features.socialtracking.skipURLs" = "*.instagram.com, *.twitter.com, *.twimg.com";

        /** OCSP & CERTS / HPKP ***/
        # Use CRLite instead of OCSP
        "security.OCSP.enabled" = 0;
        "security.OCSP.require" = false;
        "security.pki.crlite_mode" = 2;

        /** RFP ***/
        # Limits refresh rate to 60mHz, breaks timezone, and forced light theme
        # [1] https://librewolf.net/docs/faq/#what-are-the-most-common-downsides-of-rfp-resist-fingerprinting
        "privacy.resistFingerprinting" = false;

        # WebGL
        # Breaks Map sites, NYT articles, Nat Geo, and more
        # [1] https://manu.ninja/25-real-world-applications-using-webgl/
        "webgl.disabled" = false;

        # DRM
        # Netflix, Udemy, Spotify, etc.
        "media.eme.enabled" = true;

        /** HTTPS-ONLY MODE ***/
        "dom.security.https_only_mode_error_page_user_suggestions" = true;

        /** PASSWORDS AND AUTOFILL ***/
        "signon.generation.enabled" = false;

        /** WEBRTC ***/
        # Breaks video conferencing
        "media.peerconnection.ice.no_host" = false;

        /** PERMISSIONS ***/
        "permissions.default.geo" = 2;
        "permissions.default.desktop-notification" = 2;
        "dom.push.enabled" = false;

        /****************************************************************************
         * SECTION: PESKYFOX                                                        *
        ****************************************************************************/
        /** MOZILLA UI ***/
        "layout.css.prefers-color-scheme.content-override" = 2;
        "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
        "browser.compactmode.show" = true;

        /** FULLSCREEN ***/
        "full-screen-api.transition-duration.enter" = "0 0";
        "full-screen-api.transition-duration.leave" = "0 0";
        "full-screen-api.warning.delay" = 0;
        "full-screen-api.warning.timeout" = 0;

        /** URL BAR ***/
        "browser.urlbar.suggest.engines" = false;
        "browser.urlbar.suggest.topsites" = false;
        "browser.urlbar.suggest.calculator" = true;
        "browser.urlbar.unitConversion.enabled" = true;

        /** AUTOPLAY ***/
        # Default breaks some video players
        "media.autoplay.blocking_policy" = 0;

        /** PASSWORDS ***/
        "editor.truncate_user_pastes" = false;

        /** DOWNLOADS ***/
        "browser.download.autohideButton" = true;
        "browser.download.useDownloadDir" = true;

        /** PDF ***/
        "browser.download.open_pdf_attachments_inline" = true;

        /** TAB BEHAVIOR ***/
        "browser.tabs.loadBookmarksInTabs" = true;
        "browser.bookmarks.openInTabClosesMenu" = false;
        "findbar.highlightAll" = true;
      };
    };

    wayland.windowManager.hyprland.settings = {
      bind = mkIf cfg.configureKeybindings [ "SUPER_ALT, W, exec, uwsm app -- ${config.programs.librewolf.package}/bin/librewolf" ];
      exec-once = mkIf cfg.autostart [ "[workspace ${toString cfg.workspace} silent] uwsm app -- ${config.programs.librewolf.package}/bin/librewolf" ];
      windowrulev2 = [
        "idleinhibit fullscreen, class:librewolf, title:(Youtube)"
        "float, class:librewolf, title:^Extension: \(NoScript\) - NoScript"
        #FIXME initial title is librewolf
        #TODO no fullscreen
      ];
    };

    # needs inputs.xdg-autostart.homeManagerModules.xdg-autostart
    xdg.autoStart.packages = mkIf cfg.autostart [ config.programs.librewolf.package ];
  };
}
