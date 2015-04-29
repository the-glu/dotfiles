local nocolor="%{$terminfo[sgr0]%}"
local green="%{$nocolor$fg[green]%}"
local red="%{$nocolor$fg[red]%}"
local blue="%{$nocolor$fg[blue]%}"
local cyan="%{$nocolor$fg[cyan]%}"
local darkgreen="%{$nocolor$fg[green]%}"
local darkred="%{$nocolor$fg[red]%}"
local darkblue="%{$nocolor$fg[blue]%}"
local darkcyan="%{$nocolor$fg[cyan]%}"
local magenta="%{$nocolor$fg[magenta]%}"

# Add time on the right
setopt transient_rprompt
RPS1="  %{$fg[blue]%}%D{%d/%m/%y %H:%M:%S}%{$terminfo[sgr0]%}"

# Allow for functions in the prompt.
setopt PROMPT_SUBST

if [[ "$ZSH_FULL_PROMPT" == "yes" ]]; then
  source ~/.zsh/theme-full.sh
else
  source ~/.zsh/theme-simple.sh
fi
