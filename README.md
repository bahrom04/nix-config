<p align="center">
    <picture>
        <source media="(prefers-color-scheme: dark)" srcset="./.github/assets/nix-config-header.png">
        <img alt="Welcome Image" src="./.github/assets/nix-config-header.png">
    </picture>
</p>

# NixOS
```bash
sudo nixos-rebuild switch --flake .#nixos #use hostname here

nix build .#nixosConfigurations.bahrom04.config.system.build.toplevel --show-trace
```

### Install from live iso. Disko
```bash
# Clone the repository
git clone https://github.com/bahrom04/nix-config.git

# Partition disks regarding to configuration
# Replace ? with available hostname
sudo nix --experimental-features "nix-command flakes" run github:nix-community/disko/latest -- --mode disko ./hosts/?/disk-configuration.nix

# Install using flake configurations on top of partitioned disks
# Replace ? with available hostname
sudo nixos-install --flake .#?
```

# nix-darwin
```bash
sudo darwin-rebuild switch --flake .#air
--option tarball-ttl 0 # no caching

nix build .#darwinConfigurations.bahrom04.config.system.build.toplevel --show-trace
```

## Code formatter and checkers & delete cache
```bash
nix fmt .
nix flake check --all-systems --show-trace

nix repl :lf .

# geting narHash
nix flake prefetch "github:xinux-org/modules"
# getting rev
git rev-parse main

## delete old generations
sudo nix-collect-garbage -d
```

## Edit secrets 
```bash
nix develop
EDITOR=vim sops ./secrets/secrets.yaml
```

## Python
```bash
poetry run python test/web.py
```

<p align="center">
    <picture>
        <source media="(prefers-color-scheme: dark)" srcset="./.github/assets/nix-config-footer.png">
        <img alt="Welcome Image" src="./.github/assets/nix-config-footer.png">
    </picture>
</p>