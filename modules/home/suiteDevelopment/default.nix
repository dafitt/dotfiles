{ options, config, lib, pkgs, osConfig ? { }, ... }:

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
    dafitt = {
      vscode.autostart = true;
      vscode.enable = true;
    };

    home.packages = with pkgs; [
      clang-tools # clangd for c/c++
      dig # tool for DNS
      fira-code-symbols # the ligatures aviable as symbols
      gcc # gnu c compiler
      gnome-nettool
      gnumake # makefile
      gucharmap # to search unicode characters
      httpie # a modern command line HTTP client
      mtr # better traceroute
      nerd-fonts.fira-code
      nerd-fonts.fira-mono
      nil # nix language server
      nix-prefetch # Prefetch any fetcher function call, e.g. package sources
      nix-prefetch-github # Prefetch sources from github
      nixpkgs-fmt # nix code formatter
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

    programs.direnv.enable = true;
    home.sessionVariables.DIRENV_LOG_FORMAT = ""; # silents direnv

    # Distributed version control system
    # https://git-scm.com/
    programs.git = {
      enable = true;

      extraConfig = {
        init = { defaultBranch = "main"; };
        pull = { rebase = true; };
        core = { whitespace = "trailing-space,space-before-tab"; };
      };
    };

    programs.firefox.profiles.${config.home.username}.extensions = with pkgs.nur.repos.rycee.firefox-addons; [
      github-file-icons
    ];

    # Enable hyprland debug logs
    # https://wiki.hyprland.org/Configuring/Variables/#debug
    wayland.windowManager.hyprland.settings.debug = {
      # current log #$ cat $XDG_RUNTIME_DIR/hypr/$(ls -t $XDG_RUNTIME_DIR/hypr/ | head -n 1)/hyprland.log
      # last log #$ cat $XDG_RUNTIME_DIR/hypr/$(ls -t $XDG_RUNTIME_DIR/hypr/ | head -n 2 | tail -n 1)/hyprland.log
      disable_logs = false;
    };
  };
}
