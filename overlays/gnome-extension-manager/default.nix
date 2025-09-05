{ channels, inputs, ... }:

self: super: {
  # until #369069 gets merged: https://nixpk.gs/pr-tracker.html?pr=369069
  gnome-extension-manager = super.gnome-extension-manager.overrideAttrs (old: {
    src = super.fetchFromGitHub {
      owner = "mjakeman";
      repo = "extension-manager";
      rev = "v0.6.0";
      hash = "sha256-AotIzFCx4k7XLdk+2eFyJgrG97KC1wChnSlpLdk90gE=";
    };
    patches = [ ];
    buildInputs = with super; [
      blueprint-compiler
      gtk4
      json-glib
      libadwaita
      libsoup_3
      libbacktrace
      libxml2
    ];
  });
}
