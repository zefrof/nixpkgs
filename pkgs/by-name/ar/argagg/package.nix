{
  lib,
  stdenv,
  fetchFromGitHub,
  cmake,
}:

stdenv.mkDerivation (finalAttrs: {
  pname = "argagg";
  version = "0.4.7";

  src = fetchFromGitHub {
    owner = "vietjtnguyen";
    repo = "argagg";
    tag = finalAttrs.version;
    hash = "sha256-G0PzoKpUyb1MaziLvHgasq98jPODUu4EgPzywRjuIN8=";
  };

  nativeBuildInputs = [
    cmake
  ];

  meta = {
    homepage = "https://github.com/vietjtnguyen/argagg";
    description = "Argument Aggregator";
    longDescription = ''
      argagg is yet another C++ command line argument/option parser. It was
      written as a simple and idiomatic alternative to other frameworks like
      getopt, Boost program options, TCLAP, and others. The goal is to achieve
      the majority of argument parsing needs in a simple manner with an easy to
      use API. It operates as a single pass over all arguments, recognizing
      flags prefixed by - (short) or -- (long) and aggregating them into easy to
      access structures with lots of convenience functions. It defers processing
      types until you access them, so the result structures end up just being
      pointers into the original command line argument C-strings.
    '';
    license = lib.licenses.mit;
    maintainers = with lib.maintainers; [ ];
    platforms = lib.platforms.all;
    badPlatforms = [ "aarch64-darwin" ];
  };
})
