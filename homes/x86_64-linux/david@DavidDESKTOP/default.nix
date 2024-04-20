{ lib, ... }: with lib.dafitt; {

  dafitt = {
    desktops.hyprland.monitors = [{
      name = "DP-1";
      width = 2560;
      height = 1440;
      refreshRate = 120;
      workspace = "1";
      primary = true;
    }];

    desktops.hyprland.hypridle.timeouts.lock = 0;
    desktops.hyprland.hypridle.timeouts.suspend = 0;
    desktops.hyprland.hyprlock.enable = false;
    editing.enableSuite = true;
    environment.bedtime.enable = true;
    environment.filemanagers.yazi.enable = true;
    environment.launchers.rofi.enable = true;
    music.enableSuite = true;
    office.enableSuite = true;
    ricing.enableSuite = true;
    social.enableSuite = true;
    web.enableSuite = true;
  };

  services.flatpak.overrides."com.valvesoftware.Steam".Context.filesystems = [ "/mnt/games" ];
}
