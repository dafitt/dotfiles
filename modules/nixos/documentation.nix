{ config, lib, ... }:
with lib;
{
  documentation.enable = mkDefault false;

  documentation.man = {
    man-db.enable = false;
    mandoc.enable = config.documentation.man.enable; # faster than man-db
  };
}
