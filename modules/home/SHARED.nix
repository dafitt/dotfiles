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
      editor-micro
      fastfetch
      file-roller
      fileManager-nautilus
      flatpak
      imv
      launcher-fuzzel
      mpv
      noctalia
      passwordManager-bitwarden
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
      xdg
    ];

  dafitt = mkDefault {
    browser-firefox.setAsDefaultBrowser = true;
    editor-micro.setAsDefaultEditor = true;
    fileManager-nautilus.setAsDefaultFileManager = true;
    noctalia.setAsDefaultLauncher = true;
    passwordManager-keepassxc.setAsDefaultPasswordManager = true;
    terminal-kitty.setAsDefaultTerminal = true;
    top-btop.setAsDefaultTop = true;
  };
}
