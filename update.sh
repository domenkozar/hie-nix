#!/bin/sh
STACK2NIX=$(nix-build -A stack2nix)/bin/stack2nix

COMMIT=94703051cf0de1c5eaa032ed66ca82e53f1414ab
URL=https://github.com/haskell/haskell-ide-engine.git

# needed since that's how stack2nix finds compiler, etc
NIXPKGS_COMMIT=$(nix-shell -p jq --run "jq -r '.rev' nixpkgs-src.json")
export NIX_PATH=nixpkgs=https://github.com/NixOS/nixpkgs/archive/$NIXPKGS_COMMIT.tar.gz

$STACK2NIX --revision $COMMIT $URL --stack-yaml=stack-8.4.4.yaml > ghc-8.4.nix
$STACK2NIX --revision $COMMIT $URL --stack-yaml=stack-8.2.2.yaml > ghc-8.2.nix
