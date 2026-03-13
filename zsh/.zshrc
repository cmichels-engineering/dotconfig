# Enable Powerlevel10k instant prompt. Must stay at top.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

HISTFILE=~/.zsh_history
SAVEHIST=9000
HISTSIZE=9999
setopt EXTENDED_HISTORY
setopt HIST_EXPIRE_DUPS_FIRST
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_SPACE
setopt INC_APPEND_HISTORY

# Zap plugin manager
[ -f "${XDG_DATA_HOME:-$HOME/.local/share}/zap/zap.zsh" ] && source "${XDG_DATA_HOME:-$HOME/.local/share}/zap/zap.zsh"

plug "zsh-users/zsh-autosuggestions"
plug "zap-zsh/supercharge"
plug "zsh-users/zsh-syntax-highlighting"
plug "zap-zsh/vim"
plug "zap-zsh/fzf"
plug "romkatv/powerlevel10k"

# custom completions
FPATH+=~/.config/zsh/completions
autoload -Uz compinit
compinit

# p10k prompt
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# config modules
plug "$HOME/.config/zsh/aliases.zsh"
plug "$HOME/.config/zsh/exports.zsh"
plug "$HOME/.config/zsh/functions.zsh"
plug "$HOME/.config/zsh/bindings.zsh"
plug "$HOME/.config/zsh/prompt.zsh"

bindkey "^[[A" history-search-backward
bindkey "^[[B" history-search-forward

# platform-specific config
if [[ "$(uname -s)" == "Darwin" ]]; then
  plug "$HOME/.config/zsh/platform/mac.zsh"
  plug "$HOME/.config/zsh/platform/mac-aliases.zsh"
elif grep -qi microsoft /proc/version 2>/dev/null; then
  plug "$HOME/.config/zsh/platform/wsl.zsh"
  plug "$HOME/.config/zsh/platform/wsl-aliases.zsh"
fi
