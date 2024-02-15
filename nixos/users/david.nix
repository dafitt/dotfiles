{ config, pkgs, inputs, ... }: {

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
      inputs.home-manager.packages.${pkgs.system}.default
    ] ++ config.users.users.root.packages;

    openssh.authorizedKeys.keyFiles = [ ];
  };

  # Default Shell
  programs.fish = {
    enable = true;
    # also use objects provided by other packages
    vendor = {
      completions.enable = true;
      config.enable = true;
      functions.enable = true;
    };
  };

  #* home-manager is used 'standalone'
}
