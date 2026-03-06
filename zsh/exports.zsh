#!/bin/sh
# HISTFILE="$XDG_DATA_HOME"/zsh/history
HISTSIZE=1000000
SAVEHIST=1000000
export EDITOR="nvim"

export PATH="$HOME/.local/bin":$PATH
export HOMEBREW_NO_ANALYTICS=1
export HOMEBREW_NO_ENV_HINTS=1
eval "$(zoxide init zsh)"

# Go
export PATH=$PATH:/usr/local/go/bin
export PATH=$PATH:~/go/bin

# Zig
export PATH=$PATH:~/zig

# kubectl
export PATH="${KREW_ROOT:-$HOME/.krew}/bin:$PATH"
source <(kubectl completion zsh)


export GPG_TTY=$(tty)

# Prevent macOS from creating ._ AppleDouble files on external volumes
export COPYFILE_DISABLE=1

# nvm
# TODO: add to alias to engage when using nvm
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

eval "$(fzf --zsh)"

export PATH=$PATH:~/tools
export PATH=$PATH:~/tools/kafka/bin

# sdkman
source "$HOME/.sdkman/bin/sdkman-init.sh"
