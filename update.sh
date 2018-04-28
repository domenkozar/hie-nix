#!/bin/sh
STACK2NIX=$(nix-build -A stack2nix)/bin/stack2nix

COMMIT=0aa338d072c603b91c1ddff4805e4b0eb9440de4
URL=https://github.com/haskell/haskell-ide-engine.git

$STACK2NIX --git-recursive --revision $COMMIT $URL > ghc-8.2.nix
$STACK2NIX --git-recursive --revision $COMMIT $URL --stack-yaml=stack-8.0.2.yaml > ghc-8.0.nix
