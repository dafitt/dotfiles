{ inputs, ... }:
{
  meta.doc = "A suite of LaTeX editors and tools for creating and editing LaTeX documents.";

  imports = with inputs; [ nix-flatpak.homeManagerModules.nix-flatpak ];

  services.flatpak = {
    packages = [
      {
        appId = "app.gummi.gummi";
        origin = "flathub";
      } # simple and fast LaTeX editor
      {
        appId = "org.texstudio.TeXstudio";
        origin = "flathub";
      } # more feature-rich LaTeX editor
      {
        appId = "fyi.zoey.TeX-Match";
        origin = "flathub";
      } # find LaTeX symbols by sketching
    ];
    overrides = {
      "app.gummi.gummi".Context.filesystems = [ "home" ];
    };
  };
}
