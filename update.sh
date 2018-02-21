STACK2NIX=$(nix-build -A stack2nix)/bin/stack2nix 

COMMIT=725db6af3c5a672571ae1a05919725639f1fee5e
URL=https://github.com/haskell/haskell-ide-engine.git
  
$STACK2NIX --revision $COMMIT $URL > ghc-8.2.nix
$STACK2NIX --revision $COMMIT $URL --stack-yaml=stack-8.0.2.yaml > ghc-8.0.nix
