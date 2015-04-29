if [[ $UID -eq 0 ]]; then
    PS1="${darkred}%n${nocolor}@${green}%m${nocolor}:${magenta}%~${nocolor}%#${nocolor} "
else
    PS1="${darkblue}%n${nocolor}@${green}%m${nocolor}:${magenta}%~${nocolor}%#${nocolor} "
fi

