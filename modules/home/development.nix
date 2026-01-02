{
  config,
  lib,
  pkgs,
  inputs,
  perSystem,
  ...
}:
with lib;
{
  imports = with inputs; [
    self.homeModules.flatpak

    self.homeModules.shell-fish
    self.homeModules.shell-nushell
    self.homeModules.starship
    self.homeModules.gditor-vscode
    self.homeModules.gditor-zed-editor
  ];

  dafitt = mkDefault {
    zed-editor.setAsDefaultGditor = true;
  };

  home.packages = with pkgs; [
    clang-tools
    dig
    fira-code-symbols
    gcc
    glow
    gnumake
    gucharmap
    httpie
    hyperfine
    mtr
    nerd-fonts.fira-code
    nerd-fonts.fira-mono
    nil
    nix-converter
    nix-prefetch
    nix-prefetch-github
    nixd
    nixpkgs-fmt
    tldr
    tokei
    wev
    yed
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
    with perSystem.nur.repos.rycee.firefox-addons; [
      github-file-icons
    ];

  # Enable hyprland debug logs
  # https://wiki.hypr.land/Configuring/Variables/#debug
  wayland.windowManager.hyprland.settings.debug = {
    # current log #$ cat $XDG_RUNTIME_DIR/hypr/$(ls -t $XDG_RUNTIME_DIR/hypr/ | head -n 1)/hyprland.log
    # last log #$ cat $XDG_RUNTIME_DIR/hypr/$(ls -t $XDG_RUNTIME_DIR/hypr/ | head -n 2 | tail -n 1)/hyprland.log
    disable_logs = false;
  };
}
