```bash
## Cheat sheet

nix run nixpkgs#nixos-anywhere -- --flake .#demo nixos@192.168.122.99

# Execute colmena
nix shell github:zhaofengli/colmena
colmena apply --on demo
```