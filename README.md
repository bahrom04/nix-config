<p align="center">
    <picture>
        <source media="(prefers-color-scheme: dark)" srcset="./.github/assets/nix-config-header.png">
        <img alt="Welcome Image" src="./.github/assets/nix-config-header.png">
    </picture>
</p>

## NixOS in x86_64-linux branch
sudo nixos-rebuild switch --flake .#nixos

## nix-darwin in main branch
```
sudo darwin-rebuild switch --flake .#bahrom04
--option tarball-ttl 0 # no caching

nix build .#darwinConfigurations.bahrom04.config.system.build.toplevel --show-trace
```

## Code formatter and checkers
```
nix fmt .
nix flake check --all-systems --show-trace
nix repl # and inside type ":lf ."
nix run nixpkgs#nix-tree
```

## To edit secrets
Check that environment variable has proper sops path
```
nix develop
sops ./secrets/secrets.yaml
```

<p align="center">
    <picture>
        <source media="(prefers-color-scheme: dark)" srcset="./.github/assets/nix-config-footer.png">
        <img alt="Welcome Image" src="./.github/assets/nix-config-footer.png">
    </picture>
</p>
