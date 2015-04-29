
unsetopt beep notify
autoload terminfo colors
colors
watch=all

# Folders
setopt auto_name_dirs
setopt auto_pushd
setopt pushd_ignore_dups
setopt pushdminus

ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets pattern)

# Colors
for f in /etc/DIR_COLORS ${HOME}/.dir_colors; do
    [ -f "$f" ] && eval `dircolors -b "$f"`
done

# Usefull vars
export EDITOR=vim
