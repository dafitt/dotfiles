{
  #meta.doc = builtins.toFile "doc.md" "Adds declared certificates to the system.";

  security.pki.certificateFiles = [
    ./clan-ca.crt
  ];
}
