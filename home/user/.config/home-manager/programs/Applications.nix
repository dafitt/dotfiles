{ pkgs, ... }: {

  home.packages = with pkgs; [
    # search packages here: <https://search.nixos.org/packages>

    clapper # a simple and modern GNOME media player
    gnome.gnome-characters # character picker
    hunspell # Spell checking
    hunspellDicts.de_DE
    hunspellDicts.en_US-large
    libreoffice-fresh # office suite
    gamehub
    tenacity # Sound editor with graphical UI

    # for development and administration
    gnome.dconf-editor
    gnome.gnome-tweaks
    gnome.gnome-nettool
    gnome.gucharmap # to search unicode characters
    pandoc # document converter
    wireshark # network protocol analyzer
  ];
}
