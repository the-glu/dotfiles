bindkey -v

bindkey "^R" history-incremental-search-backward
bindkey "^S" history-incremental-search-forward
# Delete
bindkey '^[[3~' delete-char
# PageUp/PageDown and Home/End
bindkey '^[[5~' history-search-backward
bindkey '^[[6~' history-search-forward
bindkey '^[[7~' beginning-of-line
bindkey '^[[4~' end-of-line
# GNU Screen !?!
bindkey '^[[1~' beginning-of-line
bindkey '^[[8~' end-of-line

bindkey '^[[H' beginning-of-line
bindkey '^[[F' end-of-line
case $TERM in (xterm*)
        bindkey '\eOH' beginning-of-line
        bindkey '\eOF' end-of-line
esac

bindkey -e
bindkey '\ew' kill-region
bindkey -s '\el' "ls\n"
bindkey '^r' history-incremental-search-backward
bindkey "^[[5~" up-line-or-history
bindkey "^[[6~" down-line-or-history

# make search up and down work, so partially type and hit up/down to find relevant stuff
bindkey '^[[A' up-line-or-search
bindkey '^[[B' down-line-or-search

bindkey "^[[H" beginning-of-line
bindkey "^[[1~" beginning-of-line
bindkey "^[OH" beginning-of-line
bindkey "^[[F"  end-of-line
bindkey "^[[4~" end-of-line
bindkey "^[OF" end-of-line
bindkey ' ' magic-space    # also do history expansion on space

bindkey "^[[1;5C" forward-word
bindkey "^[[1;5D" backward-word

bindkey '^[[Z' reverse-menu-complete

# Make the delete key (or Fn + Delete on the Mac) work instead of outputting a ~
bindkey '^?' backward-delete-char
bindkey "^[[3~" delete-char
bindkey "^[3;5~" delete-char
bindkey "\e[3~" delete-char
