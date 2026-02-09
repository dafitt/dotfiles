{ pkgs, ... }:
{
  meta.doc = "Configures the coreutils on your system.";

  environment.systemPackages = with pkgs; [
    uutils-coreutils-noprefix
  ];
}
