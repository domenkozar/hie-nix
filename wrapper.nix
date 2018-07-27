{ lib, writeScriptBin
, hie80, hie82, hie84
}:

writeScriptBin "hie" ''
#!/usr/bin/env bash

GHCBIN='ghc'
if type -f stack >/dev/null; then
  # Prefer stack, if available
  GHCBIN='stack ghc --'
fi

versionNumber=$($GHCBIN --version)
HIEBIN='hie'
case $versionNumber in
  *8.0*)
      HIEBIN='${lib.getBin hie80}/bin/hie'
      ;;
  *8.2*)
      HIEBIN='${lib.getBin hie82}/bin/hie'
      ;;
  *8.4*)
      HIEBIN='${lib.getBin hie84}/bin/hie'
      ;;
esac

$HIEBIN $@
''
