#!/bin/sh

alias zsh-update-plugins="find "$ZDOTDIR/plugins" -type d -exec test -e '{}/.git' ';' -print0 | xargs -I {} -0 git -C {} pull -q"

alias e="exit"

# colorize grep
alias grep='grep --color=auto'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'

# safety
alias cp="cp -i"
alias mv='mv -i'
alias rm='rm -i'

# disk
alias df='df -h'
alias free='free -m'

# zsh
alias zshconfig="nvim ~/.config/zsh"
alias sourceme="source ~/.zshrc"

alias notes="nvim ~/drafts.txt"
alias vnotes="nvim ~/vnotes.txt"

# java
alias gw="./gradlew"

# nvim
alias nvimrc="nvim ~/.config/nvim"
alias onvimrc="nvim ~/.config/nvim"
alias v="nvim ."
alias vim="nvim ."
alias vn='NVIM_APPNAME="nvim_old" nvim .'

# git
alias gpo="git pull origin"
alias gpod="git pull origin dev"
alias gpu="git push origin"
alias gswitch="gh auth switch"

# docker
alias d="docker"
alias dc="docker compose"

# kubectl
alias kk="kubectl kustomize"

# tools
alias cat="bat"
alias ls="eza -al"
alias lsd="eza -ald"
alias c="z"

# go
alias gtf="go test -json -v ./... 2>&1 | tee /tmp/gotest.log | gotestfmt"
alias gtc="go test -cover -json ./... | gotestfmt"
alias gosingle="go test ./internal/events -run TestEventsSuiteRunner/TestEventService_GetHis_setCache"

# lazygit
alias lg="lazygit"

# claude — alias to ccs for session management (save/resume per tmux pane)
# ccs/cls/cr live in ~/projects/personal/claude-config/bin/ symlinked to ~/bin/
alias claude=ccs

# just
alias jb="just build"
alias jt="just test"
alias jwt="just watch-test"
alias jtd="just testdata"
alias jcu="just dcu"
alias jcd="just dcd"
alias jcr="just drs"
