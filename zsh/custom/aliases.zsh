alias zshreload="source ~/.zshrc"
alias wip="git add . && git commit -m 'WIP(Work In Progress)'"
alias code="cd $HOME/Code/"
alias lg="lazygit"

# Navigation
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."

# Listing
alias ll="ls -lAFh"
alias la="ls -A"

# Utilities
mkcd() { mkdir -p "$1" && cd "$1"; }

# Editor
export EDITOR=nvim
