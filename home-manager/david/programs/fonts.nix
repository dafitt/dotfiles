{ pkgs, ... }: {

  fonts.fontconfig.enable = true; # discover fonts and configurations installed through home.packages and nix-env
  home.packages = with pkgs; [
    (nerdfonts.override { fonts = [ "FiraCode" "JetBrainsMono" ]; })
    fira-code-symbols # the ligatures aviable as symbols
    #font-awesome
    cantarell-fonts
    liberation_ttf
    inter
  ];
}
