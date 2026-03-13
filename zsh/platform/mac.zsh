# platform/mac.zsh
# macOS-specific shell configuration
# Sourced automatically on Darwin by .zshrc

# Homebrew completions and tools
if type brew &>/dev/null; then
  FPATH="$(brew --prefix)/share/zsh/site-functions:${FPATH}"
  autoload -Uz compinit
  compinit
  autoload -U +X bashcompinit && bashcompinit
  complete -o nospace -C /opt/homebrew/bin/terraform terraform
fi

# Powerlevel10k (Homebrew-managed on Mac)
source /opt/homebrew/share/powerlevel10k/powerlevel10k.zsh-theme

# Azure CLI completion
autoload bashcompinit && bashcompinit
source $(brew --prefix)/etc/bash_completion.d/az

# macOS env
export HOMEBREW_NO_ANALYTICS=1
export HOMEBREW_NO_ENV_HINTS=1
export COPYFILE_DISABLE=1
