{ pkgs, inputs, ... }:
{
  imports = with inputs; [
    niri.homeModules.niri
    self.homeModules.noctalia
  ];

  programs.niri = {
    enable = true;
    package = pkgs.niri; # follow nixpkgs

    # https://github.com/sodiboo/niri-flake/blob/main/docs.md
    settings = { };
  };
}
