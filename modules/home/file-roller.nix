{ pkgs, ... }:
{
  # GNOME's archive manager
  home.packages = with pkgs; [
    file-roller
  ];
}
