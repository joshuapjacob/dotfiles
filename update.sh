#!/bin/sh
set -e

# Update all flake inputs to their latest revisions.
sudo nix flake update --flake .config/nix

# Rebuild and activate the nix-darwin system configuration for host "stygian".
sudo darwin-rebuild switch --flake .config/nix#stygian

# Remove old Nix store generations and their unreachable dependencies to free disk space.
nix-collect-garbage -d

# Re-symlink all dotfiles from this repo into $HOME using GNU Stow.
stow .
