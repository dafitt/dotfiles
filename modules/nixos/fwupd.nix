{
  meta.doc = ''
    Adds `fwupdmgr` (firmware update manager) to your system.

    To update various firmware, see <https://wiki.nixos.org/wiki/Fwupd>.
  '';

  services.fwupd.enable = true;
}
