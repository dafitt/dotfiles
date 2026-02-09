{ config, lib, ... }:
with lib;
{
  #meta.doc = builtins.toFile "doc.md" "Optimizes the documentation on your system.";

  documentation.enable = mkDefault false;

  documentation.man = {
    man-db.enable = false;
    mandoc.enable = config.documentation.man.enable; # faster than man-db
  };
}
