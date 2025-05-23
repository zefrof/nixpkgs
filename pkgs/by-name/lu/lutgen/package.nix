{
  lib,
  fetchFromGitHub,
  rustPlatform,
  stdenv,
  installShellFiles,
}:

rustPlatform.buildRustPackage rec {
  pname = "lutgen";
  version = "0.11.2";

  src = fetchFromGitHub {
    owner = "ozwaldorf";
    repo = "lutgen-rs";
    tag = "v${version}";
    hash = "sha256-jmMVeDDVb/TuxulDYj+8y4Kl42EJTAWb3tAsanfWduE=";
  };

  useFetchCargoVendor = true;
  cargoHash = "sha256-BEh8Wl0X1wv53w/Zu0PHwh8oGtCvIJe60aVqLbiH1Hs=";

  nativeBuildInputs = [ installShellFiles ];

  postInstall = lib.optionalString (stdenv.buildPlatform.canExecute stdenv.hostPlatform) ''
    installShellCompletion --cmd lutgen \
      --bash <($out/bin/lutgen --bpaf-complete-style-bash) \
      --fish <($out/bin/lutgen --bpaf-complete-style-fish) \
      --zsh <($out/bin/lutgen --bpaf-complete-style-zsh)
  '';

  meta = with lib; {
    description = "Blazingly fast interpolated LUT generator and applicator for arbitrary and popular color palettes";
    homepage = "https://github.com/ozwaldorf/lutgen-rs";
    maintainers = with maintainers; [
      ozwaldorf
      zzzsy
      donovanglover
    ];
    mainProgram = "lutgen";
    license = licenses.mit;
  };
}
