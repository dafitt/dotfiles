{ inputs, ... }:
{
  imports = with inputs; [ home-manager.nixosModules.home-manager ];

  home-manager = {
    backupFileExtension = "hm-old"; # Move existing files rather than failing
  };
}
