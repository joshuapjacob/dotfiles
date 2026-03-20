# dotfiles

These are my personal dotfiles, managed with Nix flakes for a reproducible
setup. I use Nix-darwin on macOS with Homebrew integration, and GNU Stow to
handle symlinking of config files.

The hostname of my MacBook is `stygian`.

## Install

```shell
# Install nix through the Determinate nix installer.
curl --proto '=https' --tlsv1.2 -sSf -L https://install.determinate.systems/nix | sh -s -- install --determinate

# Clone the dotfiles.
git clone https://github.com/joshuapjacob/dotfiles
cd dotfiles

# Install the nix-darwin flake.
sudo nix run nix-darwin/master#darwin-rebuild -- switch --flake .config/nix#stygian

# Symlink all dotfiles with stow.
stow .
```

## Update

```shell
bash update.sh
```

## TODO

- ripgrep
- starship (shell prompt)
- fzf
- zbd
- stow
- jq
- pass
- doppler cli
- gh cli
- fd
- zoxide
- eze
