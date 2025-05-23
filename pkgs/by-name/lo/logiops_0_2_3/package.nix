{
  lib,
  stdenv,
  fetchFromGitHub,
  pkg-config,
  cmake,
  udev,
  libevdev,
  libconfig,
}:

stdenv.mkDerivation rec {
  pname = "logiops";
  version = "0.2.3";

  src = fetchFromGitHub {
    owner = "pixlone";
    repo = "logiops";
    tag = "v${version}";
    hash = "sha256-1v728hbIM2ODtB+r6SYzItczRJCsbuTvhYD2OUM1+/E=";
  };

  PKG_CONFIG_SYSTEMD_SYSTEMDSYSTEMUNITDIR = "${placeholder "out"}/lib/systemd/system";

  nativeBuildInputs = [
    cmake
    pkg-config
  ];
  buildInputs = [
    udev
    libevdev
    libconfig
  ];

  meta = with lib; {
    description = "Unofficial userspace driver for HID++ Logitech devices";
    mainProgram = "logid";
    homepage = "https://github.com/PixlOne/logiops";
    license = licenses.gpl3Plus;
    maintainers = [ ];
    platforms = with platforms; linux;
  };
}
