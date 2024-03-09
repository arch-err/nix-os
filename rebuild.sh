#!/usr/bin/env bash

# set -e

HOST="default"
BUILD_CMD="nixos-rebuild switch --flake "/etc/nixos/nix-os#$HOST""
LOGFILE="nixos-switch.log"
test -z $EDITOR && EDITOR="vim"

cd ~/.os/hosts/$HOST


"$EDITOR" configuration.nix

# if which alejandra &>/dev/null
# then
#     alejandra . &>/dev/null
# fi
# 
# git diff -U0 *.nix
# 
# echo "NixOS Rebuilding..."
sudo $BUILD_CMD | tee "$LOGFILE" 

# if grep "error" "$LOGFILE"
# then
#   echo -en "\e[0;31m"
#   echo "Errors were found :("
#   echo -en "\e[0m"
# fi

# grep --color error "$LOGFILE" 

gen=$($BUILD_CMD list-generations | grep current)

git commit -am "$gen"

cd - &>/dev/null
