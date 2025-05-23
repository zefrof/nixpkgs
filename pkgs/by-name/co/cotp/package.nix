{
  lib,
  stdenv,
  rustPlatform,
  fetchFromGitHub,
  libxcb,
}:

rustPlatform.buildRustPackage rec {
  pname = "cotp";
  version = "1.9.2";

  src = fetchFromGitHub {
    owner = "replydev";
    repo = "cotp";
    tag = "v${version}";
    hash = "sha256-5wVIjh16AYwrzjbPgvjsQhihu/vwdQfzU2kZS6eSTWs=";
  };

  useFetchCargoVendor = true;
  cargoHash = "sha256-6VdlXQymOFZgMksGRQ7f9ZGrzKblYlQAoBFUhi4wuM0=";

  buildInputs = lib.optionals stdenv.hostPlatform.isLinux [ libxcb ];

  meta = with lib; {
    homepage = "https://github.com/replydev/cotp";
    description = "Trustworthy, encrypted, command-line TOTP/HOTP authenticator app with import functionality";
    license = licenses.gpl3Only;
    maintainers = with maintainers; [ davsanchez ];
    mainProgram = "cotp";
  };
}
