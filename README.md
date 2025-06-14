## NixOS
sudo nixos-rebuild switch --flake .#nixos

## nix-darwin
```
sudo darwin-rebuild switch --flake .#bahrom04

nix build .#darwinConfigurations.bahrom04.config.system.build.toplevel --show-trace
```

## Code formatter and checkers
```
nix fmt .
nix flake check --all-systems --show-trace
```

## To edit secrets 
```
nix develop
EDITOR=vim sops ./secrets/secrets.yaml
```