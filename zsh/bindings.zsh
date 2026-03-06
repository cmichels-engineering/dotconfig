
#customr
bindkey "^B" vi-backword-blank-word
bindkey "^W" vi-forward-blank-word
bindkey "^Y" vi-yank-whole-line
bindkey "^A" beginning-of-line

bindkey -r "^C" # self-insert
bindkey -r "^D" # list-choices
bindkey "^E" end-of-line
bindkey "^F" self-insert
bindkey "^G" list-expand
bindkey "^H" vi-backward-delete-char
bindkey "^I" fzf-completion
bindkey "^J" accept-line
bindkey "^K" self-insert
bindkey "^L" clear-screen
bindkey "^M" accept-line
bindkey -R "^N"-"^P" self-insert
bindkey "^Q" vi-quoted-insert
bindkey "^R" fzf-history-widget
bindkey "^S" self-insert
bindkey "^T" fzf-file-widget
bindkey "^U" vi-kill-line
bindkey "^V" vi-quoted-insert

bindkey "^X^R" _read_comp
bindkey "^X?" _complete_debug
bindkey "^XC" _correct_filename
bindkey "^Xa" _expand_alias
bindkey "^Xc" _correct_word
bindkey "^Xd" _list_expansions
bindkey "^Xe" _expand_word
bindkey "^Xh" _complete_help
bindkey "^Xm" _most_recent_file
bindkey "^Xn" _next_tags
bindkey "^Xt" _complete_tag
bindkey "^X~" _bash_list-choices
bindkey "^Z" self-insert
bindkey "^[" vi-cmd-mode
bindkey "^[," _history-complete-newer
bindkey "^[/" _history-complete-older
bindkey "^[OA" up-line-or-history
bindkey "^[OB" down-line-or-history
bindkey "^[OC" vi-forward-char
bindkey "^[OD" vi-backward-char
bindkey "^[[200~" bracketed-paste
bindkey "^[[A" history-search-backward
bindkey "^[[B" history-search-forward
bindkey "^[[C" vi-forward-char
bindkey "^[[D" vi-backward-char
bindkey "^[c" fzf-cd-widget
bindkey "^[~" _bash_complete-word
bindkey -R "^\\\\"-"~" self-insert
bindkey "^?" backward-delete-char
bindkey -R "\M-^@"-"\M-^?" self-insert
