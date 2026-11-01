HISTFILE=~/.histfile

HISTSIZE=20000
SAVEHIST=10000

setopt extended_history
setopt extendedglob
setopt hist_expire_dups_first
setopt hist_ignore_dups # ignore duplication command history list
setopt hist_ignore_space
setopt hist_verify
setopt inc_append_history
