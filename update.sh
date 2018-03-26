STACK2NIX=$(nix-build -A stack2nix)/bin/stack2nix

COMMIT=d1053a5e0abac9beb9616bcc7105af883467aca6
URL=https://github.com/haskell/haskell-ide-engine.git

$STACK2NIX --revision $COMMIT $URL > ghc-8.2.nix
$STACK2NIX --revision $COMMIT $URL --stack-yaml=stack-8.0.2.yaml > ghc-8.0.nix
