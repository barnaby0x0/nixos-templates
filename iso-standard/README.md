# generate a custom iso
nix shell nixpkgs#nixos-generators
nixos-generate -f iso -c configuration.nix
```
