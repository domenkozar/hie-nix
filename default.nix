
let
  pkgs = import (import ./fetch-nixpkgs.nix) {};
  hie80Pkgs = (import ./ghc-8.0.nix { inherit pkgs; }).override {
    overrides = self: super: {
      # TODO: unnecessary with https://github.com/input-output-hk/stack2nix/issues/84#issuecomment-362035573
      Cabal = null;
    };
  };
  versions = {
    "hie-8.0" = hie80Pkgs.haskell-ide-engine;
    "hie-8.2" = (import ./ghc-8.2.nix { inherit pkgs; }).haskell-ide-engine;
  };
in with pkgs; {
 hies = runCommandNoCC "hies" {} ''
   mkdir -p $out/bin
   ln -s ${versions."hie-8.0"}/bin/hie $out/bin/hie-8.0
   ln -s ${versions."hie-8.2"}/bin/hie $out/bin/hie-8.2
 '';
} // versions
