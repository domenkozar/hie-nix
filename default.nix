{ pkgs ? (import (import ./fetch-nixpkgs.nix) {}) }:

let
  hie80Pkgs = (import ./ghc-8.0.nix { inherit pkgs; }).override {
    overrides = self: super: {
      # TODO: unnecessary with https://github.com/input-output-hk/stack2nix/issues/84#issuecomment-362035573
      Cabal = null;
    };
  };
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
 stack2nix = import (pkgs.fetchFromGitHub {
   # https://github.com/input-output-hk/stack2nix/pull/120
   owner = "nh2";
   repo = "stack2nix";
   rev = "b8668e17d5b3c5035bd88720c637ae1d333c2ebe";
   sha256 = "0dv6xy89qyrhw3yxl8qvh72skgglpvx9h5ynmhb1j8nrnxv2y5vs";
 }) { inherit pkgs; };
 hies = runCommandNoCC "hies" {
   buildInputs = [ makeWrapper ];
 } ''
   mkdir -p $out/bin
   ln -s ${hie80}/bin/hie $out/bin/hie-8.0
   ln -s ${hie82}/bin/hie $out/bin/hie-8.2
   ln -s ${hie84}/bin/hie $out/bin/hie-8.4
   makeWrapper ${hie84}/bin/hie-wrapper $out/bin/hie-wrapper \
     --prefix PATH : $out/bin
 '';
 hie80 = jse hie80Pkgs.haskell-ide-engine;
 hie82 = jse (import ./ghc-8.2.nix { inherit pkgs; }).haskell-ide-engine;
 hie84 = jse hie84Pkgs.haskell-ide-engine;
}
