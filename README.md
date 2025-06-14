sudo nixos-rebuild switch --flake .#nixos

## Daun darwin
sudo darwin-rebuild switch --flake .#bahrom04

nix build .#darwinConfigurations.bahrom04.config.system.build.toplevel --show-trace
nix flake check --all-systems --show-trace