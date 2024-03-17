{ ... }: {

  boot.loader.timeout = 5;

  hardware.tuxedo-rs = {
    enable = true;
    tailor-gui.enable = true;
  };
}
