{
  imports = [
    ./desktopEnvironment-mustHaves.nix
  ];

  programs.hyprland = {
    enable = true;

    # https://wiki.hypr.land/Useful-Utilities/Systemd-start/
    withUWSM = true;
  };

  # used by plugins
  nix.settings = {
    substituters = [
      "https://hyprland.cachix.org"
      "https://hyprland-community.cachix.org"
    ];
    trusted-public-keys = [
      "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
      "hyprland-community.cachix.org-1:5dTHY+TjAJjnQs23X+vwMQG4va7j+zmvkTKoYuSXnmE="
    ];
  };

  # Allow hyprlock to unlock the screen
  security.pam.services.hyprlock.text = "auth include login";
}
