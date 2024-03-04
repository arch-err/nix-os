#!/usr/bin/env bash


HOST="default"

set -e
#pushd "~/.os/hosts/$HOST/"
cd  "$HOME/.os/hosts/$HOST/"
"$EDITOR" configuration.nix
# alejandra . &>/dev/null
#git diff -U0 *.nix
echo "NixOS Rebuilding..."
sudo nixos-rebuild switch --flake "/etc/nixos/nix-os#$HOST" # &>nixos-switch.log || ( cat nixos-switch.log | grep --color error && false)
gen=$(nixos-rebuild --flake "/etc/nixos/nix-os#$HOST" list-generations | grep current)
git commit -am "$gen"
cd - 
# popd
