if status is-interactive
    alias ll="lsd -la"  # https://github.com/lsd-rs/lsd
    alias cat="bat"     # https://github.com/sharkdp/bat 
    alias df="duf"      # https://github.com/muesli/duf
    alias r="ranger"    # https://github.com/ranger/ranger
    alias diff="delta"  # https://github.com/dandavison/delta
end

# Remove greeting.
set fish_greeting

# Default editor is (neo)vim.
set -x EDITOR vim
