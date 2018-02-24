STACK2NIX=$(nix-build -A stack2nix)/bin/stack2nix

COMMIT=5b8150471ad416329d987edec99332e113c2d0e4
URL=https://github.com/haskell/haskell-ide-engine.git

$STACK2NIX --revision $COMMIT $URL > ghc-8.2.nix
$STACK2NIX --revision $COMMIT $URL --stack-yaml=stack-8.0.2.yaml > ghc-8.0.nix
