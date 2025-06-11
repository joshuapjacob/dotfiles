{
  description = "Stygian System Flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin = {
      url = "github:nix-darwin/nix-darwin/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs@{ self, nix-darwin, nixpkgs }:
  let
    configuration = { pkgs, ... }: {

      nix = {
        enable = false; # Managed by Determinate Nix
        settings.experimental-features = "nix-command flakes";
      };

      nixpkgs = {
        hostPlatform = "aarch64-darwin"; # Apple Silicon
        config.allowUnfree = true;
      };

      environment.systemPackages = with pkgs; [
        # CLIs
        bat
        delta
        duf
        fish
        fzf
        htop
        lsd
        ncdu
        neovim
        ranger
        rustup
        stow
        transmission_4
        uv

        # GUIs
        google-chrome
        spotify
        vlc-bin
        vscode

        # LaTeX
        (pkgs.texlive.combine {
          inherit (pkgs.texlive)
            scheme-basic
            charter
            enumitem
            fontawesome5
            marvosym
            preprint
            titlesec
            xcolor;
        })
      ];

      homebrew = {
          enable = true;
          onActivation = {
            cleanup = "uninstall";
            autoUpdate = true;
          };
          casks = [
            "google-drive"
            "telegram-desktop"
          ];
      };

      # MacOS
      system = {
        stateVersion = 6;
        primaryUser = "joshuapjacob";
        defaults = {
          dock = {
            autohide = true;
            persistent-apps = [
              "/Applications/Telegram Desktop.app"
              "${pkgs.google-chrome}/Applications/Google Chrome.app"
              "${pkgs.vscode}/Applications/Visual Studio Code.app"
              "${pkgs.spotify}/Applications/Spotify.app"
              "/System/Applications/Utilities/Terminal.app"
            ];
          };
          loginwindow.GuestEnabled = false;
          NSGlobalDomain = {
            AppleInterfaceStyle = "Dark";
            AppleICUForce24HourTime = true;
            KeyRepeat = 2;
            NSAutomaticWindowAnimationsEnabled = false;
          };
        };

        # Set git commit hash for darwin-version.
        configurationRevision = self.rev or self.dirtyRev or null;
      };


      # Enable Touch ID for sudo.
      security.pam.services.sudo_local.touchIdAuth = true;

      # Enable alternative shell support for fish in nix-darwin.
      programs.fish.enable = true;

      # Use zsh as default login shell but use fish as interactive shell.
      programs.zsh.enable = true;
      programs.zsh = {
        # The following launches fish unless the parent process is already fish.
        interactiveShellInit = ''
          if [[ "$(ps -p $PPID -o comm=)" != "fish" && -z "$ZSH_EXECUTION_STRING" ]]; then
            [[ -o login ]] && LOGIN_OPTION="--login" || LOGIN_OPTION=""
            exec ${pkgs.fish}/bin/fish $LOGIN_OPTION
          fi
        '';
      };
      
    };
  in
  {
    darwinConfigurations.stygian = nix-darwin.lib.darwinSystem {
      modules = [ configuration ];
    };
  };
}
