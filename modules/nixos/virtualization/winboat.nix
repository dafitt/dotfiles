# imports = [
#   (import ../../modules/nixos/winboat.nix { inherit pkgs; user = "david"; })
# ];

{ pkgs, user, ... }:
{
  virtualisation.docker = {
    enable = true;
  };

  users.users.${user} = {
    extraGroups = [
      "docker"
    ];
    packages = with pkgs; [
      freerdp
      winboat
    ];
  };
}
