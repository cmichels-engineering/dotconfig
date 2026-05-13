# platform/wsl-aliases.zsh
# WSL2-specific aliases
# Sourced automatically on WSL2 by .zshrc

# Project-local tooling paths (machine-local overrides supported)
: "${DOT_WORK_ROOT:=$HOME/projects}"
: "${DOT_PRIMARY_PROJECT:=work}"

alias dc-dev="${DOT_WORK_ROOT}/${DOT_PRIMARY_PROJECT}/dev/dev"
alias mc="${DOT_WORK_ROOT}/${DOT_PRIMARY_PROJECT}/multi-compose/mc"
