{ options, config, lib, pkgs, inputs, ... }:

with lib;
with lib.custom;
let
  cfg = config.system.users.david;
in
{
  options.system.users.david = with types; {
    enable = mkBoolOpt true "Enable user david";
  };

  config = mkIf cfg.enable {
    users.users."david" = {
      isNormalUser = true;
      description = "David Schaller";
      extraGroups =
        let
          ifTheyExist = groups: builtins.filter (group: builtins.hasAttr group config.users.groups) groups;
        in
        [
          "wheel" # for sudo
          "video" # for light (backlight control)
        ] ++ ifTheyExist [
          "deluge"
          "git"
          "libvirtd"
          "networkmanager"
          "wireshark"
        ];

      packages = with pkgs; [
        inputs.home-manager.packages.${pkgs.system}.default
      ] ++ config.users.users.root.packages;

      openssh.authorizedKeys.keyFiles = [ ];
    };

    nix.settings.trusted-users = [ "david" ];
  };
}
