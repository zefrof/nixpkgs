{
  fetchFromGitHub,
  buildPythonPackage,
  cargo,
  rustPlatform,
  rustc,
  setuptools,
  setuptools-rust,
  numpy,
  fixtures,
  networkx,
  testtools,
  libiconv,
  stdenv,
  lib,
  pytestCheckHook,
}:

buildPythonPackage rec {
  pname = "rustworkx";
  version = "0.15.1";
  pyproject = true;

  src = fetchFromGitHub {
    owner = "Qiskit";
    repo = "rustworkx";
    tag = version;
    hash = "sha256-0WYgShihTBM0e+MIhON0dnhZug6l280tZcVp3KF1Jq0=";
  };

  cargoDeps = rustPlatform.fetchCargoVendor {
    inherit src;
    hash = "sha256-TfBDyh4cc1gt29I6wEKuF1QWczgeK+naApSD1aFDcvs=";
  };

  nativeBuildInputs = [
    rustPlatform.cargoSetupHook
    cargo
    rustc
  ];

  build-system = [
    setuptools
    setuptools-rust
  ];

  buildInputs = [ numpy ] ++ lib.optionals stdenv.hostPlatform.isDarwin [ libiconv ];

  nativeCheckInputs = [
    fixtures
    networkx
    pytestCheckHook
    testtools
  ];

  preCheck = ''
    rm -r rustworkx
  '';

  pythonImportsCheck = [ "rustworkx" ];

  meta = with lib; {
    description = "High performance Python graph library implemented in Rust";
    homepage = "https://github.com/Qiskit/rustworkx";
    license = licenses.asl20;
    maintainers = with maintainers; [ raitobezarius ];
  };
}
