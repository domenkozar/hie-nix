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
   rev = "067ee42b10743c999ce8967ba8dab7218de4f160";
   sha256 = "0hip039ap8vm0w00vjbzb5p8wsb2l9bb6bppzpnqrcyrf7h3q26p";
 }) { inherit pkgs; };
 hies = runCommandNoCC "hies" {} ''
   mkdir -p $out/bin
   ln -s ${hie80}/bin/hie $out/bin/hie-8.0
   ln -s ${hie82}/bin/hie $out/bin/hie-8.2
 '';
 hie80 = hie80Pkgs.haskell-ide-engine;
 hie82 = (import ./ghc-8.2.nix { inherit pkgs; }).haskell-ide-engine;
}
