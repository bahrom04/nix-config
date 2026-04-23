rebuild hostname:
  sudo nixos-rebuild switch --flake .#{{hostname}} --show-trace

check:
  nix flake check --show-trace

update:
  nix flake update --show-trace

commit message:
  git commit -m "{{message}}"
