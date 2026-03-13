#!/bin/sh

export EDITOR="nvim"

export PATH="$HOME/.local/bin:$PATH"

eval "$(zoxide init zsh)"

# Go
export PATH=$PATH:/usr/local/go/bin
export PATH=$PATH:$HOME/go/bin

# Work
export GOPRIVATE=github.com/Stark-Tech-Group/*
export GONOSUMDB=github.com/Stark-Tech-Group/*

# kubectl
export PATH="${KREW_ROOT:-$HOME/.krew}/bin:$PATH"

# Node — lazy load nvm behind nodemode (avoids ~350ms startup cost)
export NVM_DIR="$HOME/.nvm"
nodemode() {
  [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
  [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"
  echo "nvm loaded. node: $(node --version 2>/dev/null)"
  unfunction nodemode
}

# Java — lazy load sdkman behind javamode
javamode() {
  export SDKMAN_DIR="$HOME/.sdkman"
  [[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"
  echo "sdkman loaded. java: $(java -version 2>&1 | head -1)"
}

# kubectl completion — lazy load on first k invocation
k() {
  source <(kubectl completion zsh) 2>/dev/null
  unfunction k
  alias k=kubectl
  kubectl "$@"
}
