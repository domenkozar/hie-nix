{ pkgs ? (import (import ./fetch-nixpkgs.nix) {}) }:

let
  hie80Pkgs = (import ./ghc-8.0.nix { inherit pkgs; }).override {
    overrides = self: super: {
      # TODO: unnecessary with https://github.com/input-output-hk/stack2nix/issues/84#issuecomment-362035573
      Cabal = null;
    };
  };
  versions = {
  };
in with pkgs; rec {
 stack2nix = import (pkgs.fetchFromGitHub {
   owner = "sectore";
   repo = "stack2nix";
   rev = "f95772fc762c5a0d9e3caded6ca5b98711fb85ad";
   sha256 = "02mi3945b41kj7a9pqgkd0s7ipi41lhj61xp24ady2vrb3wz0iaq";
 }) { inherit pkgs; };
 hies = runCommandNoCC "hies" {} ''
   mkdir -p $out/bin
   ln -s ${hie80}/bin/hie $out/bin/hie-8.0
   ln -s ${hie82}/bin/hie $out/bin/hie-8.2
 '';
 hie80 = hie80Pkgs.haskell-ide-engine;
 hie82 = (import ./ghc-8.2.nix { inherit pkgs; }).haskell-ide-engine;
}
