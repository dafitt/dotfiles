{ pkgs, ... }:
{
  environment.variables = {
    # Enable icons in tooling since we have nerdfonts.
    LOG_ICONS = "true";
  };

  fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
    nerd-fonts.noto
    nerd-fonts.symbols-only
    nerd-fonts.ubuntu
    nerd-fonts.ubuntu-mono
    nerd-fonts.ubuntu-sans
    open-sans
  ];
}
