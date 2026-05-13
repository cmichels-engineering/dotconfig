#!/usr/bin/env zsh

# Load machine-local overrides (symlink-safe via ~/.config/zsh/local.zsh)
[[ -f "$HOME/.config/zsh/local.zsh" ]] && source "$HOME/.config/zsh/local.zsh"

export EDITOR="nvim"

export PATH="$HOME/.local/bin:$PATH"

eval "$(zoxide init zsh)"

# Go
export PATH=$PATH:/usr/local/go/bin
export PATH=$PATH:$HOME/go/bin

# Work
export DOT_GH_ORG="${DOT_GH_ORG:-example-org}"
export GOPRIVATE="${GOPRIVATE:-github.com/${DOT_GH_ORG}/*}"
export GONOSUMDB="${GONOSUMDB:-github.com/${DOT_GH_ORG}/*}"


#atlassian

# kubectl
export PATH="${KREW_ROOT:-$HOME/.krew}/bin:$PATH"

# Node — default node on PATH immediately, nvm lazy-loads on first use
# Sync: version must match WSLfile NODE_VERSION (currently lts/jod = Node 22)
export NVM_DIR="$HOME/.nvm"
export PATH="$NVM_DIR/versions/node/v22.22.1/bin:$PATH"
nvm() {
  unfunction nvm
  [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
  nvm "$@"
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
