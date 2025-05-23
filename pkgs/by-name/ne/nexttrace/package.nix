{
  lib,
  buildGoModule,
  fetchFromGitHub,
  stdenv,
}:

buildGoModule rec {
  pname = "nexttrace";
  version = "1.3.5";

  src = fetchFromGitHub {
    owner = "nxtrace";
    repo = "NTrace-core";
    tag = "v${version}";
    sha256 = "sha256-32QFgmvXQ+8ix1N9I6pJaIJGWOT67/FG0VVEhftwQQw=";
  };
  vendorHash = "sha256-WRH9doQavcdH1sd2fS8QoFSmlirBMZgSzB/sj1q6cUQ=";

  doCheck = false; # Tests require a network connection.

  ldflags = [
    "-s"
    "-w"
    "-X github.com/nxtrace/NTrace-core/config.Version=v${version}"
  ];

  postInstall = ''
    mv $out/bin/NTrace-core $out/bin/nexttrace
  '';

  meta = with lib; {
    description = "Open source visual route tracking CLI tool";
    homepage = "https://mtr.moe";
    license = licenses.gpl3Only;
    maintainers = with maintainers; [ sharzy ];
    mainProgram = "nexttrace";
    # Broken on darwin for Go toolchain > 1.22, with error:
    # 'link: github.com/nxtrace/NTrace-core/trace/internal: invalid reference to net.internetSocket'
    broken = stdenv.hostPlatform.isDarwin;
  };
}
