{
  lib,
  fetchCrate,
  rustPlatform,
}:

rustPlatform.buildRustPackage rec {
  pname = "dye-cli";
  version = "0.4.2";

  src = fetchCrate {
    inherit pname version;
    hash = "sha256-ls6UQUppSkUsDJhzx8oleG1Gk7XSmZmLw4a4hYWj3Sg=";
  };

  cargoHash = "sha256-J2rh+cfmysCIMve4G9HnYjKKXs8pquhIYsd/l0xRPHQ=";

  meta = {
    description = "A CLI tool to easily color text in your shell";
    homepage = "https://github.com/kurtbuilds/dye";
    license = lib.licenses.mit;
    mainProgram = "dye";
  };
}
