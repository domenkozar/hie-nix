#!/bin/sh
STACK2NIX=$(nix-build -A stack2nix)/bin/stack2nix

COMMIT=dd65c3b0b40a6ac5ce125d72eb708c1b74703dc2
URL=https://github.com/haskell/haskell-ide-engine.git

$STACK2NIX --git-recursive --revision $COMMIT $URL > ghc-8.2.nix
$STACK2NIX --git-recursive --revision $COMMIT $URL --stack-yaml=stack-8.0.2.yaml > ghc-8.0.nix
