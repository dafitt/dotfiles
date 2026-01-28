{
  inputs,
  lib,
  ...
}:
with lib;
{
  imports =
    with inputs;
    with inputs.self.homeModules;
    [
      browser-firefox
      calculator
      desktopEnvironment-hyprland
      desktopEnvironment-niri
      editor-micro
      fastfetch
      file-roller
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
