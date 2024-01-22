{ config, pkgs, home-manager, ... }: {

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
        "networkmanager"
        "wireshark"
        "i2c"
        "mysql"
        "docker"
        "podman"
        "git"
        "libvirtd"
        "deluge"
      ];
    shell = pkgs.fish;

    packages = with pkgs; [
      home-manager.packages.${pkgs.system}.default
    ] ++ config.users.users.root.packages;

    openssh.authorizedKeys.keyFiles = [ ];
  };
}
