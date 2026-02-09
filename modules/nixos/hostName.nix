{ hostName, ... }:
{
  #meta.doc = builtins.toFile "doc.md" "Sets the hostname on your system.";

  networking.hostName = hostName;
}
