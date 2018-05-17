#!/bin/sh
STACK2NIX=$(nix-build -A stack2nix)/bin/stack2nix

COMMIT=c68ba8d5cfb9cb89d04efd2bbda575d055a5e10b
URL=https://github.com/haskell/haskell-ide-engine.git

$STACK2NIX --git-recursive --revision $COMMIT $URL > ghc-8.2.nix
$STACK2NIX --git-recursive --revision $COMMIT $URL --stack-yaml=stack-8.0.2.yaml > ghc-8.0.nix
