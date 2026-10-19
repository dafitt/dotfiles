{ pkgs, ... }:
{
  home.packages = with pkgs; [
    quickemu
    quickgui
  ];

  programs.umbriel.settings = {
    window_rule = [
      {
        match.app_id = "^quickgui$";
        default_floating = true;
      }
    ];
  };
}
