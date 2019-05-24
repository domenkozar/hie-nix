#!/usr/bin/env sh

set -xe

# needed since that's how stack2nix finds compiler, etc
export NIX_PATH="nixpkgs=$PWD/nix"

STACK2NIX="$(nix-build -A stack2nix --no-out-link)/bin/stack2nix"

# If we don't set this, the some packages fail to build with Unicode errors
glibcLocales=$(nix-build --no-out-link -A glibcLocales "<nixpkgs>")
export LOCALE_ARCHIVE_2_27="${glibcLocales}/lib/locale/locale-archive"


URL="https://github.com/haskell/haskell-ide-engine.git"
COMMIT="$(jq -r '."haskell-ide-engine".rev' nix/sources.json)"

"$STACK2NIX" --revision "$COMMIT" "$URL" --stack-yaml=stack-8.6.4.yaml > ghc-8.6.nix
"$STACK2NIX" --revision "$COMMIT" "$URL" --stack-yaml=stack-8.4.4.yaml > ghc-8.4.nix
"$STACK2NIX" --revision "$COMMIT" "$URL" --stack-yaml=stack-8.2.2.yaml > ghc-8.2.nix
