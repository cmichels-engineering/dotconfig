# platform/mac-aliases.zsh
# macOS-specific aliases
# Sourced automatically on Darwin by .zshrc

# Homebrew
alias bb="brew bundle"

# Yoink — macOS drag/drop utility
alias yo="open -a yoink"

# Video to GIF (requires ffmpeg, gifsicle, osascript)
# alias v2g='function video_to_gif(){ ffmpeg -i "$1" "${1%.*}.gif" && gifsicle -O3 --lossy=80 --colors=64 --scale 0.8 "${1%.*}.gif" -o "${1%.*}.gif" && osascript -e "display notification \"${1%.*}.gif successfully converted and saved\" with title \"MOV2GIF SUCCESS!\""};video_to_gif'
