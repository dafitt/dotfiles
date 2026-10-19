{ inputs, ... }:
{
  #meta.doc = builtins.toFile "doc.md" "Personal settings.";

  imports = with inputs.self.homeModules; [
    archiveManager
    audio
    browser-firefox
    calculator
    desktopEnvironment-umbriel
    editor-micro
    fastfetch
    fileManager-thunar
    flatpak
    imv
    mpv
    noctalia
    nwg-drawer
    obsidian
    passwordManager-keepassxc
    personalEnvironment
    playerctld
    starship
    stylix
    syncthing
    systemd
    tailscale
    terminal-alacritty
    top-btop
    wluma
    xdg
  ];

  dafitt = {
    browser-firefox.autostart = true;
    browser-firefox.setAsDefaultBrowser = true;
    editor-micro.setAsDefaultEditor = true;
    fileManager-thunar.setAsDefaultFileManager = true;
    noctalia.setAsDefaultLauncher = true;
    passwordManager-keepassxc.setAsDefaultPasswordManager = true;
    shell-fish.setAsDefaultShell = true;
    terminal-alacritty.setAsDefaultTerminal = true;
    top-btop.setAsDefaultTop = true;
  };

  programs.git.settings.user = {
    name = "dafitt";
    email = "dafitt@posteo.me";
  };
}
