{ config, pkgs, ... }: {
  users.users.david = {
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
        "wireshark"
        "i2c"
        "mysql"
        "docker"
        "podman"
        "git"
        "libvirtd"
        "deluge"
      ];
    shell = pkgs.zsh;

    openssh.authorizedKeys.keyFiles = [ ];
  };
}
