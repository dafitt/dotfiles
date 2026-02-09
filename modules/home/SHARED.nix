{
  inputs,
  lib,
  ...
}:
with lib;
{
  #meta.doc = builtins.toFile "doc.md" "A collection of default modules beeing shared across home environments.";

  imports =
    with inputs;
    with inputs.self.homeModules;
    [
      archiveManager
      browser-firefox
      calculator
      desktopEnvironment-hyprland
      desktopEnvironment-niri
      editor-micro
      fastfetch
      fileManager-thunar
      flatpak
      imv
      mpv
      noctalia
      nwg-drawer
      passwordManager-keepassxc
      personalEnvironment
      playerctld
      starship
      stylix
      syncthing
      systemd
      tailscale
      terminal-kitty
      top-btop
      web
      wlsunset
      wluma
      xdg
    ];

  dafitt = mkDefault {
    browser-firefox.autostart = true;
    browser-firefox.setAsDefaultBrowser = true;
    editor-micro.setAsDefaultEditor = true;
    fileManager-thunar.setAsDefaultFileManager = true;
    noctalia.setAsDefaultLauncher = true;
    passwordManager-keepassxc.setAsDefaultPasswordManager = true;
    terminal-kitty.setAsDefaultTerminal = true;
    top-btop.setAsDefaultTop = true;
  };
}
