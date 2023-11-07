{ pkgs, ... }: {

  # sync files with other machines
  # https://syncthing.net/
  #home.packages = [ pkgs.syncthing ];

  wayland.windowManager.hyprland.settings = {
    bind = [ "ALT SUPER, Z, exec, xdg-open https://localhost:8384" ];
    exec-once = [ "${pkgs.syncthing}/bin/syncthing serve --no-browser" ];
  };
}
