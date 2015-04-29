HISTFILE=~/.histfile

HISTSIZE=10000
SAVEHIST=10000

setopt append_history
setopt extended_history
setopt extendedglob
setopt hist_expire_dups_first
setopt hist_ignore_dups # ignore duplication command history list
setopt hist_ignore_space
setopt hist_verify
setopt inc_append_history

# Colors
for f in /etc/DIR_COLORS ${HOME}/.dir_colors; do
    [ -f "$f" ] && eval `dircolors -b "$f"`
done

# Usefull vars
export EDITOR=vim
