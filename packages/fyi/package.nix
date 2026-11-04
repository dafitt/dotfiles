{
  lib,
  fetchFromGitHub,
  rustPlatform,
  installShellFiles,
}:

rustPlatform.buildRustPackage (finalAttrs: {
  pname = "fyi";
  version = "2.7.1";

  src = fetchFromGitHub {
    owner = "Blobfolio";
    repo = "fyi";
    tag = "v${finalAttrs.version}";
    hash = "sha256-kr+aOsIg7x+kQZm8hPC0KmFQ86JwHm4v8n48Gew+Ljk=";
  };

  cargoHash = "sha256-7NBSFaVhwhWdMwwswqJrzt8J/LNVHlOLlLuXxxGsxyg=";

  cargoBuildFlags = [
    "--package"
    "fyi"
    "--bin"
    "fyi"
  ];

  cargoTestFlags = [
    "--package"
    "fyi"
  ];

  nativeBuildInputs = [ installShellFiles ];

  postInstall = ''
    installShellCompletion --bash release/completions/fyi.bash
    installManPage release/man/*.1
  '';

  meta = {
    description = "Colorful status messages for shell scripts";
    homepage = "https://github.com/Blobfolio/fyi";
    license = lib.licenses.wtfpl;
    mainProgram = "fyi";
    platforms = [ "x86_64-linux" ];
  };
})
