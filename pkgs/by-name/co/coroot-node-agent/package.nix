{
  lib,
  buildGoModule,
  fetchFromGitHub,
  systemdLibs,
}:

buildGoModule rec {
  pname = "coroot-node-agent";
  version = "1.23.15";

  src = fetchFromGitHub {
    owner = "coroot";
    repo = "coroot-node-agent";
    tag = "v${version}";
    hash = "sha256-3rr8LWaEhhAvzJisVj2uLK3O5us5/XEOpl7RFL2GBxw=";
  };

  vendorHash = "sha256-SxyIlyDHuu8Ls1+/rujWE9elZiTfSYWIrV8vP5xsqTU=";

  buildInputs = [ systemdLibs ];

  CGO_CFLAGS = "-I ${systemdLibs}/include";

  meta = {
    description = "Prometheus exporter based on eBPF";
    homepage = "https://github.com/coroot/coroot-node-agent";
    license = lib.licenses.asl20;
    maintainers = with lib.maintainers; [ errnoh ];
    mainProgram = "coroot-node-agent";
  };
}
