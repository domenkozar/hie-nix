{ pkgs ? (import (import ./fetch-nixpkgs.nix) {}) }:

let
  hie84Pkgs = (import ./ghc-8.4.nix { inherit pkgs; }).override {
    overrides = self: super: {
      # https://github.com/input-output-hk/stack2nix/issues/103
      ghc-syb-utils = null;
      # GHC 8.4 core libs
      mtl = null;
      parsec = null;
      stm = null;
      text = null;
      Cabal = null;
    };
  };
  jse = pkgs.haskell.lib.justStaticExecutables;
in with pkgs; rec {
 stack2nix = pkgs.stack2nix;
 hies = runCommandNoCC "hies" {
   buildInputs = [ makeWrapper ];
 } ''
   mkdir -p $out/bin
   ln -s ${hie82}/bin/hie $out/bin/hie-8.2
   ln -s ${hie84}/bin/hie $out/bin/hie-8.4
   makeWrapper ${hie84}/bin/hie-wrapper $out/bin/hie-wrapper \
     --prefix PATH : $out/bin
 '';
 hie82 = jse (import ./ghc-8.2.nix { inherit pkgs; }).haskell-ide-engine;
 hie84 = jse hie84Pkgs.haskell-ide-engine;
}
