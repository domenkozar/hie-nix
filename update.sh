STACK2NIX=$(nix-build -A stack2nix)/bin/stack2nix 

COMMIT=8edd031fc9c53539d53a634e24ca6be8062dcbff
URL=https://github.com/haskell/haskell-ide-engine.git
  
$STACK2NIX --revision $COMMIT $URL > ghc-8.2.nix
$STACK2NIX --revision $COMMIT $URL --stack-yaml=stack-8.0.2.yaml > ghc-8.0.nix
