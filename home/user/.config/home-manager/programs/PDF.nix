{ pkgs, ... }: {

  # the tools for dealing with PDFs
  home.packages = with pkgs; [
    pdfarranger # merge split rotate crop rearrange pdf pages
    evince # GNOME's document viewer
  ];

  programs.zathura = {
    enable = true;
  };
}
