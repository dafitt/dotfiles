{
  config,
  lib,
  pkgs,
  osConfig ? { },
  ...
}:

with lib;
with lib.dafitt;
let
  cfg = config.dafitt.suiteDevelopment;
  osCfg = osConfig.dafitt.suiteDevelopment or null;
in
{
  options.dafitt.suiteDevelopment = with types; {
    enable = mkBoolOpt (osCfg.enable or false) "Whether to enable the Development suite.";
  };

  config = mkIf cfg.enable {
    dafitt = mkDefault {
      fish.enable = true;
      nushell.enable = true;
      starship.enable = true;
      vscode.enable = true;
      zed-editor.enable = true;
      zed-editor.setAsDefaultGditor = true;
    };

    home.packages = with pkgs; [
      clang-tools # clangd for c/c++
      dig # tool for DNS
      fira-code-symbols # the ligatures aviable as symbols
      gcc # gnu c compiler      gnome-nettool
      gnumake # makefile
      gucharmap # to search unicode characters
      httpie # a modern command line HTTP client
      hyperfine # benchmarking tool
      mtr # better traceroute
      nerd-fonts.fira-code
      nerd-fonts.fira-mono
      nil # nix language server
      nix-converter # nix <-> json/yaml/toml converter
      nix-prefetch # Prefetch any fetcher function call, e.g. package sources
      nix-prefetch-github # Prefetch sources from github
      nixd # nix language server
      nixpkgs-fmt # nix formatter
      tldr # simplified and community-driven man pages
      tokei # lines of code counter
      wev # tool for keyboard input
      yed # Drawing flowcharts
    ];

    services.flatpak.packages = [
      "com.belmoussaoui.ashpd.demo" # Play with portals
      "io.gitlab.liferooter.TextPieces" # Developer's scratchpad
      "me.iepure.devtoolbox" # Dev tools at your fingertips
      "nl.hjdskes.gcolor3" # Choose colors from the picker or the screen
      "org.gnome.meld" # Compare and merge your files
    ];

    programs.direnv = {
      enable = true;
      nix-direnv.enable = true;
    };
    home.sessionVariables.DIRENV_LOG_FORMAT = ""; # silents direnv

    # Distributed version control system
    # https://git-scm.com/
    programs.git = {
      enable = true;

      settings = {
        init = {
          defaultBranch = "main";
        };
        pull = {
          rebase = true;
        };
        core = {
          whitespace = "trailing-space,space-before-tab";
        };
      };
    };

    # TUI for Git written in Rust
    programs.gitui.enable = true;

    programs.firefox.profiles.${config.home.username}.extensions =
      with pkgs.nur.repos.rycee.firefox-addons; [
        github-file-icons
      ];

    # Enable hyprland debug logs
    # https://wiki.hypr.land/Configuring/Variables/#debug
    wayland.windowManager.hyprland.settings.debug = {
      # current log #$ cat $XDG_RUNTIME_DIR/hypr/$(ls -t $XDG_RUNTIME_DIR/hypr/ | head -n 1)/hyprland.log
      # last log #$ cat $XDG_RUNTIME_DIR/hypr/$(ls -t $XDG_RUNTIME_DIR/hypr/ | head -n 2 | tail -n 1)/hyprland.log
      disable_logs = false;
    };
  };
}
