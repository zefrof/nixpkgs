{
  lib,
  fetchFromGitHub,
  buildPythonPackage,
  pygobject3,
  xvfb-run,
  gobject-introspection,
  gtk3,
  pythonOlder,
  pytest,
  setuptools,
}:

buildPythonPackage rec {
  pname = "liblarch";
  version = "3.2.0";
  pyproject = true;

  disabled = pythonOlder "3.5";

  src = fetchFromGitHub {
    owner = "getting-things-gnome";
    repo = "liblarch";
    tag = "v${version}";
    hash = "sha256-A2qChe2z6rAhjRVX5VoHQitebf/nMATdVZQgtlquuYg=";
  };

  build-system = [
    setuptools
  ];

  nativeCheckInputs = [
    gobject-introspection # for setup hook
    gtk3
    pytest
  ];

  buildInputs = [ gtk3 ];

  propagatedBuildInputs = [ pygobject3 ];

  checkPhase = ''
    runHook preCheck
    ${xvfb-run}/bin/xvfb-run -s '-screen 0 800x600x24' pytest
    runHook postCheck
  '';

  meta = with lib; {
    description = "Python library built to easily handle data structure such are lists, trees and acyclic graphs";
    homepage = "https://github.com/getting-things-gnome/liblarch";
    downloadPage = "https://github.com/getting-things-gnome/liblarch/releases";
    license = licenses.lgpl3Plus;
    maintainers = with maintainers; [ oyren ];
    platforms = platforms.linux;
  };
}
