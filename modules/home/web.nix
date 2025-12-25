{ inputs, ... }:
{
  imports = with inputs; [
    self.homeModules.flatpak
  ];

  services.flatpak = {
    packages = [
      "de.haeckerfelix.Fragments" # Manage torrents
      "dev.geopjr.Collision" # Check hashes for your files
      "xyz.ketok.Speedtest" # Measure your internet connection speed
    ];
    overrides = {
      "dev.geopjr.Collision".Context.filesystems = [ "xdg-download:ro" ];
    };
  };
}
