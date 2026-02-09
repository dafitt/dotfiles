{
  meta.doc = "Adds declared certificates to the system.";

  security.pki.certificateFiles = [
    ./clan-ca.crt
  ];
}
