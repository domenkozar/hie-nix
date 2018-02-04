
let
  pkgs = import (import ./fetch-nixpkgs.nix) {};
  hie80Pkgs = (import ./ghc-8.0.nix { inherit pkgs; }).override {
    overrides = self: super: {
      # TODO: unnecessary with https://github.com/input-output-hk/stack2nix/issues/84#issuecomment-362035573
      Cabal = null;
    };
  };
  versions = {
  };
in with pkgs; {
 stack2nix = import (pkgs.fetchFromGitHub {
   owner = "input-output-hk";
   repo = "stack2nix";
   rev = "86f5b42524d486defe26107a37211b3faa576c39";
   sha256 = "1xgp299nm9xbl4a2wgvch4210y2xm4c53b0lqhgsp5x8sdsyyh7c";
 }) { inherit pkgs; };
 hies = runCommandNoCC "hies" {} ''
   mkdir -p $out/bin
   ln -s ${hie80}/bin/hie $out/bin/hie-8.0
   ln -s ${hie82}/bin/hie $out/bin/hie-8.2
 '';
 hie80 = hie80Pkgs.haskell-ide-engine;
 hie82 = (import ./ghc-8.2.nix { inherit pkgs; }).haskell-ide-engine;
}
