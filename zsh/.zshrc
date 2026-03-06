# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi


HISTFILE=~/.zsh_history
# Increase storage capacity
SAVEHIST=9000    # Maximum number of events saved to history file
HISTSIZE=9999    # Maximum number of events remembered during session (must be > SAVEHIST)

# Enable extended history features
setopt EXTENDED_HISTORY         # Include timestamps
setopt HIST_EXPIRE_DUPS_FIRST   # Remove duplicates first when history is full
setopt HIST_IGNORE_DUPS         # Don't save duplicate entries
setopt HIST_IGNORE_SPACE        # Don't save commands starting with space
setopt INC_APPEND_HISTORY       # Save history immediately, not just at shell exit



# Created by Zap installer
[ -f "${XDG_DATA_HOME:-$HOME/.local/share}/zap/zap.zsh" ] && source "${XDG_DATA_HOME:-$HOME/.local/share}/zap/zap.zsh"




plug "zsh-users/zsh-autosuggestions"
plug "zap-zsh/supercharge"
plug "zsh-users/zsh-syntax-highlighting"
plug "zap-zsh/vim"
plug "zap-zsh/fzf"

# load custom completions
FPATH+=~/.config/zsh/completions
autoload -Uz compinit
compinit



if type brew &>/dev/null
then
  FPATH="$(brew --prefix)/share/zsh/site-functions:${FPATH}"

  autoload -Uz compinit
  compinit
  autoload -U +X bashcompinit && bashcompinit
  complete -o nospace -C /opt/homebrew/bin/terraform terraform
fi
# Load and initialise completion system
source /opt/homebrew/share/powerlevel10k/powerlevel10k.zsh-theme

if command -v bat &> /dev/null; then
  alias cat="bat -pp --theme \"Visual Studio Dark+\""
fi
# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

#source
plug "$HOME/.config/zsh/aliases.zsh"
plug "$HOME/.config/zsh/exports.zsh"
plug "$HOME/.config/zsh/functions.zsh"
plug "$HOME/.config/zsh/bindings.zsh"
plug "$HOME/.config/zsh/prompt.zsh"

autoload bashcompinit && bashcompinit
source $(brew --prefix)/etc/bash_completion.d/az


bindkey "^[[A" history-search-backward
bindkey "^[[B" history-search-forward


