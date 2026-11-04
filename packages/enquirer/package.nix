{
  lib,
  fetchCrate,
  rustPlatform,
}:

rustPlatform.buildRustPackage rec {
  pname = "enquirer";
  version = "0.6.1";

  src = fetchCrate {
    inherit pname version;
    hash = "sha256-wwFMmtMB0bZ8ASzk4+kqYjWs8f+dnLmmDW6Z+o9f+2Q=";
  };

  cargoHash = "sha256-Hj8mlCxeE0OaVvMDuq5DYEOzsTJzrG1vfM/cajLSSMQ=";

  meta = {
    description = "Command line utility for stylish interactive prompts";
    homepage = "https://github.com/termapps/enquirer";
    license = lib.licenses.mit;
    mainProgram = "enquirer";
  };
}
