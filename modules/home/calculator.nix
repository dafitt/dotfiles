{ lib, pkgs, ... }:
with lib;
{
  #meta.doc = builtins.toFile "doc.md" "Installs and configures a calculator application.";

  home.packages = with pkgs; [ gnome-calculator ];

  programs.umbriel.settings = {
    keybinds."XF86Calculator" = {
      action = "spawn:${getExe pkgs.gnome-calculator}";
      repeat = false;
    };
    window_rule = [
      {
        match.app_id = "org.gnome.Calculator";
        default_floating = true;
      }
    ];
  };
}
