{ ... }: {
  lib = {
    path = ./lib;
  };
  module = {
    home.path = ./module/home;
    nixos.path = ./module/nixos;
  };
  overlay = {
    path = ./overlay;
  };
  system = {
    path = ./system;
  };
  home = {
    path = ./home;
  };
}
