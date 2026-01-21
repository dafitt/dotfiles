{ inputs, ... }:
{
  imports = with inputs; [ home-manager.nixosModules.home-manager ];

  home-manager = {
    backupFileExtension = "hm-old"; # Move existing files rather than failing
  };

  # https://github.com/nix-community/home-manager/blob/27b60942b7285824937f8c2c05021370f6fc5904/modules/misc/xdg-portal.nix#L39C9-L39C89
  environment.pathsToLink = [
    "/share/xdg-desktop-portal"
    "/share/applications"
  ];
}
