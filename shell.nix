with (import <nixpkgs> {});
let
  gleam-run = pkgs.writeShellScriptBin "gleam-run" ''
    deno run --allow-read --allow-write --allow-run https://raw.githubusercontent.com/brettkolodny/gleam-run/main/main.ts $1 --target=erlang
  '';
  roc = stdenv.mkDerivation rec {
    name = "roc-${version}";
    version = "2022-12-03-012810d";
    src = fetchurl {
      url = "https://github.com/roc-lang/roc/releases/download/nightly/roc_nightly-macos_12_apple_silicon-${version}.tar.gz";
      sha256 = "sha256-SUfnPaKvD3WmRXiUqcdYoU+EmfhwBW3+f5AIvlRc1SM=";
    };
    phases = [ "installPhase" ];
    installPhase = ''
      mkdir -p $out/bin
      tar -xf $src --directory $out/bin
    '';
  };
in
mkShell {
  buildInputs = [
    babashka
    clojure
    deno
    libiconv

    gleam
    gleam-run

    roc
    llvmPackages_13.llvm
  ];
}