with (import <nixpkgs> {});
let
  gleam-run = pkgs.writeShellScriptBin "gleam-run" ''
    deno run --allow-read --allow-write --allow-run https://raw.githubusercontent.com/brettkolodny/gleam-run/main/main.ts $1 --target=erlang
  '';
in
mkShell {
  buildInputs = [
    babashka
    clojure
    deno
    gleam
    gleam-run
  ];
}