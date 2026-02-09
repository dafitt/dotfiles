{ hostName, ... }:
{
  meta.doc = "Sets the hostname on your system.";

  networking.hostName = hostName;
}
