STACK2NIX=$(nix-build -A stack2nix)/bin/stack2nix

COMMIT=1051cc69d3434f4ccf67e03846410ec463135db9
URL=https://github.com/haskell/haskell-ide-engine.git

$STACK2NIX --revision $COMMIT $URL > ghc-8.2.nix
$STACK2NIX --revision $COMMIT $URL --stack-yaml=stack-8.0.2.yaml > ghc-8.0.nix
