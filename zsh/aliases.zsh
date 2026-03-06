#!/bin/sh


alias zsh-update-plugins="find "$ZDOTDIR/plugins" -type d -exec test -e '{}/.git' ';' -print0 | xargs -I {} -0 git -C {} pull -q"

alias e="exit"
# Colorize grep output (good for log files)
alias grep='grep --color=auto'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'

# confirm before overwriting something
alias cp="cp -i"
alias mv='mv -i'
alias rm='rm -i'

# easier to read disk
alias df='df -h'     # human-readable sizes
alias free='free -m' # show sizes in MB


# brew
alias bb="brew bundle"

# zsh
alias zshconfig="nvim ~/.config/zsh"
alias sourceme="source ~/.zshrc"

alias notes="nvim ~/drafts.txt"
alias vnotes="nvim ~/vnotes.txt"


# java
alias gw="./gradlew"
alias javamode="export SDKMAN_DIR="$HOME/.sdkman" && [[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh""

# npm 
alias nodemode="source <(ng completion script)"

# pulumi
alias pulumimode="p_azure_key && p_azure_account"

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
alias k=kubectl
alias kc=kubecolor
alias kk="kubectl kustomize"


# terraform
alias tf="terraform"
alias tfi="terraform init"
alias tfa="terraform apply"
alias tfp="terraform plan"
alias tfmode=""

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

# yoink
alias yo="open -a yoink"

# alias v2g='function video_to_gif(){ ffmpeg -i "$1" "${1%.*}.gif" && gifsicle -O3 --lossy=80 --colors=64 --scale 0.8 "${1%.*}.gif" -o "${1%.*}.gif" && osascript -e "display notification \"${1%.*}.gif successfully converted and saved\" with title \"MOV2GIF SUCCESS!\""};video_to_gif'
#

# just
alias jb="just build"
alias jt="just test"
alias jwt="just watch-test"
alias jtd="just testdata"
alias jcu="just dcu" # docker compose up
alias jcd="just dcd" # docker compose down
alias jcr="just drs" # docker compose restart local project container


