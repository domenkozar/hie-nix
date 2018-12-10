#!/bin/sh

set -xe

# needed since that's how stack2nix finds compiler, etc
export NIX_PATH=nixpkgs=https://github.com/NixOS/nixpkgs/archive/release-18.09.tar.gz
NIXPKGS_COMMIT=$(nix-shell -p jq --run "jq -r '.rev' nixpkgs-src.json")
export NIX_PATH=nixpkgs=https://github.com/NixOS/nixpkgs/archive/$NIXPKGS_COMMIT.tar.gz

STACK2NIX=$(nix-build -A stack2nix)/bin/stack2nix

COMMIT=1a5640f4790bde364dcd0a61617c5ca5b85b145a
URL=https://github.com/haskell/haskell-ide-engine.git


$STACK2NIX --revision $COMMIT $URL --stack-yaml=stack-8.6.2.yaml > ghc-8.6.nix
$STACK2NIX --revision $COMMIT $URL --stack-yaml=stack-8.4.4.yaml > ghc-8.4.nix
$STACK2NIX --revision $COMMIT $URL --stack-yaml=stack-8.2.2.yaml > ghc-8.2.nix
