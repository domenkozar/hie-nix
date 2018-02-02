~/.local/bin/stack2nix --revision 8edd031fc9c53539d53a634e24ca6be8062dcbff \
  https://github.com/haskell/haskell-ide-engine.git > ghc-8.2.nix

~/.local/bin/stack2nix --revision 8edd031fc9c53539d53a634e24ca6be8062dcbff \
  --stack-yaml=stack-8.0.2.yaml https://github.com/haskell/haskell-ide-engine.git > ghc-8.0.nix
