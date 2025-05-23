{
  mkDerivation,
  lib,
  fetchFromGitLab,
  qtbase,
  libzen,
  libmediainfo,
  zlib,
  cmake,
  ninja,
  libcprime,
  libcsys,
}:

mkDerivation rec {
  pname = "coreinfo";
  version = "4.5.0";

  src = fetchFromGitLab {
    owner = "cubocore/coreapps";
    repo = pname;
    tag = "v${version}";
    hash = "sha256-DmvmFMttEvNnIp1zwCe0BLrMx3Wlw1U9LcJwyb4Mx9U=";
  };

  nativeBuildInputs = [
    cmake
    ninja
  ];

  buildInputs = [
    qtbase
    libzen
    libmediainfo
    zlib
    libcprime
    libcsys
  ];

  meta = with lib; {
    description = "File information tool from the C Suite";
    mainProgram = "coreinfo";
    homepage = "https://gitlab.com/cubocore/coreapps/coreinfo";
    license = licenses.gpl3Plus;
    maintainers = with maintainers; [ dan4ik605743 ];
    platforms = platforms.linux;
  };
}
