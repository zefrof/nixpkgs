{
  lib,
  stdenv,
  fetchFromGitLab,
  meson,
  ninja,
  pkg-config,
  rustPlatform,
  rustc,
  cargo,
  wrapGAppsHook4,
  blueprint-compiler,
  libadwaita,
  libsecret,
  tinysparql,
  darwin,
  nix-update-script,
}:

stdenv.mkDerivation rec {
  pname = "health";
  version = "0.95.0";

  src = fetchFromGitLab {
    domain = "gitlab.gnome.org";
    owner = "World";
    repo = "health";
    rev = version;
    hash = "sha256-PrNPprSS98yN8b8yw2G6hzTSaoE65VbsM3q7FVB4mds=";
  };

  cargoDeps = rustPlatform.fetchCargoVendor {
    inherit src;
    name = "${pname}-${version}";
    hash = "sha256-eR1ZGtTZQNhofFUEjI7IX16sMKPJmAl7aIFfPJukecg=";
  };

  nativeBuildInputs = [
    meson
    ninja
    pkg-config
    rustPlatform.cargoSetupHook
    rustc
    cargo
    wrapGAppsHook4
    blueprint-compiler
  ];

  buildInputs =
    [
      libadwaita
      libsecret
      tinysparql
    ]
    ++ lib.optionals stdenv.hostPlatform.isDarwin [
      darwin.apple_sdk.frameworks.Security
      darwin.apple_sdk.frameworks.Foundation
    ];

  env.NIX_CFLAGS_COMPILE = toString (
    lib.optionals stdenv.cc.isClang [
      "-Wno-error=incompatible-function-pointer-types"
    ]
  );

  passthru = {
    updateScript = nix-update-script { };
  };

  meta = with lib; {
    description = "Health tracking app for the GNOME desktop";
    homepage = "https://apps.gnome.org/app/dev.Cogitri.Health";
    license = licenses.gpl3Plus;
    mainProgram = "dev.Cogitri.Health";
    maintainers = lib.teams.gnome-circle.members;
    platforms = platforms.unix;
  };
}
