# platform/wsl.zsh
# WSL2-specific shell configuration
# Sourced automatically on WSL2 by .zshrc

# GPG signing — required for git commit signing in non-interactive contexts
export GPG_TTY=$(tty)

# Ensure win32yank is available for clipboard bridging
export PATH="$HOME/.local/bin:$PATH"