{
  lib,
  stdenv,
  fetchFromGitHub,
  m4,
  installShellFiles,
  util-linux,
}:

stdenv.mkDerivation rec {
  pname = "dinit";
  version = "0.19.3";

  src = fetchFromGitHub {
    owner = "davmac314";
    repo = "dinit";
    tag = "v${version}";
    # fix for case-insensitive filesystems
    postFetch = ''
      [ -f "$out/BUILD" ] && rm "$out/BUILD"
    '';
    hash = "sha256-mhb/0EeJpUReGE2xxVXs0iUGctDOVnpR1Q+IVUtFT0Y=";
  };

  postPatch = ''
    substituteInPlace src/shutdown.cc \
      --replace-fail '"/bin/umount"' '"${util-linux}/bin/umount"' \
      --replace-fail '"/sbin/swapoff"' '"${util-linux}/bin/swapoff"'
  '';

  nativeBuildInputs = [
    m4
    installShellFiles
  ];

  configureFlags = [
    "--prefix=${placeholder "out"}"
    "--sbindir=${placeholder "out"}/bin"
  ];

  postInstall = ''
    installShellCompletion --cmd dinitctl \
      --bash contrib/shell-completion/bash/dinitctl \
      --fish contrib/shell-completion/fish/dinitctl.fish \
      --zsh contrib/shell-completion/zsh/_dinit
  '';

  meta = {
    description = "A service manager / supervision system, which can (on Linux) also function as a system manager and init";
    homepage = "https://davmac.org/projects/dinit";
    license = lib.licenses.asl20;
    maintainers = with lib.maintainers; [ aanderse ];
    platforms = lib.platforms.unix;
  };
}
