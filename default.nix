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
   owner = "sectore";
   repo = "stack2nix";
   rev = "4e4141d1f4a4626030f11bdf7623ccc7640f7b08";
   sha256 = "1v5pm770pmalxwvf6ddg196m17ga5lj30r1xq2sdd7fi330k0i27";
 }) { inherit pkgs; };
 hies = runCommandNoCC "hies" {} ''
   mkdir -p $out/bin
   ln -s ${hie80}/bin/hie $out/bin/hie-8.0
   ln -s ${hie82}/bin/hie $out/bin/hie-8.2
   ln -s ${hie84}/bin/hie $out/bin/hie-8.4
 '';
 hie80 = jse hie80Pkgs.haskell-ide-engine;
 hie82 = jse (import ./ghc-8.2.nix { inherit pkgs; }).haskell-ide-engine;
 hie84 = jse hie84Pkgs.haskell-ide-engine;
 wrapper = import ./wrapper.nix {
   inherit (pkgs) lib writeScriptBin; inherit hie80 hie82 hie84;
 };
}
