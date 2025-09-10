```bash
## Cheat sheet

nix run nixpkgs#nixos-anywhere -- --flake .#demo nixos@192.168.122.99

# Wwith hardware configuration file management
nix run nixpkgs#nixos-anywhere -- --flake .#demo nixos@10.10.0.12 --generate-hardware-config nixos-generate-config ./hardware-configuration.nix

# Execute colmena
nix shell github:zhaofengli/colmena
colmena apply --on demo
```

# generate a custom iso
nix shell nixpkgs#nixos-generators
nixos-generate -f iso -c configuration.nix
```
