#!/bin/sh
STACK2NIX=$(nix-build -A stack2nix)/bin/stack2nix

COMMIT=5c0687bb79dd974ab3fb81b2809f55fc423b1a65
URL=https://github.com/haskell/haskell-ide-engine.git

$STACK2NIX --git-recursive --revision $COMMIT $URL > ghc-8.4.nix
$STACK2NIX --git-recursive --revision $COMMIT $URL --stack-yaml=stack-8.2.2.yaml > ghc-8.2.nix
