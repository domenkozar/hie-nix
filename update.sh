#!/bin/sh
STACK2NIX=$(nix-build -A stack2nix)/bin/stack2nix

COMMIT=06de34eb53667a6b90ead0907dd002156b1638ab
URL=https://github.com/haskell/haskell-ide-engine.git

# needed since that's how stack2nix finds compiler, etc
NIXPKGS_COMMIT=$(nix-shell -p jq --run "jq -r '.rev' nixpkgs-src.json")
export NIX_PATH=nixpkgs=https://github.com/NixOS/nixpkgs/archive/$NIXPKGS_COMMIT.tar.gz

$STACK2NIX --revision $COMMIT $URL --stack-yaml=stack-8.4.3.yaml > ghc-8.4.nix
$STACK2NIX --revision $COMMIT $URL --stack-yaml=stack-8.2.2.yaml > ghc-8.2.nix

# stack2nix doesn't support manually specified revisions yet: https://github.com/input-output-hk/stack2nix/issues/127
# which haskell-ide-engine uses: https://github.com/haskell/haskell-ide-engine/pull/789
patch --no-backup-if-mismatch ghc-8.4.nix cabal-helper-revision.diff
patch --no-backup-if-mismatch ghc-8.2.nix cabal-helper-revision.diff
