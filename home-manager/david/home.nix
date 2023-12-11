# home-manager standalone

{ config, lib, pkgs, ... }: {

  nixpkgs = {
    #overlays = [ ];
    config = {
      allowUnfree = true;
      allowUnfreePredicate = _: true; # Workaround for [Flake cannot use unfree packages](https://github.com/nix-community/home-manager/issues/2942)
    };
  };

  home = {
    username = "david";
    homeDirectory = "/home/david";

    sessionVariables = {
      # Default programs
      BROWSER = "${config.programs.librewolf.package}/bin/librewolf";
      EDITOR = "${pkgs.micro}/bin/micro";
      GDITOR = "${pkgs.vscode}/bin/code";
      TERMINAL = "${config.programs.kitty.package}/bin/kitty";
      TOP = "${config.programs.btop.package}/bin/btop"; # preferred system monitor
    };

    language.base = "en_US.UTF-8";
  };


  xdg = {
    enable = true;
    cacheHome = config.home.homeDirectory + "/.local/cache";
    userDirs = {
      enable = true;
      createDirectories = true;
      extraConfig = {
        XDG_SCREENSHOTS_DIR = "${config.xdg.userDirs.pictures}/Screenshots";
        XDG_SECRETS_DIR = "${config.home.homeDirectory}/.secrets";
      };
    };
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  # For other OSes than NixOS
  #targets.genericLinux.enable = true;

  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";

  home.stateVersion = "23.05"; # [When do I update stateVersion?](https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion)
}

# more options: <https://mipmip.github.io/home-manager-option-search/?query=hyprland>
# more options: <https://nix-community.github.io/home-manager/options.html>
