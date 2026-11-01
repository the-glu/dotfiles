autoload -U add-zsh-hook

add-zsh-hook chpwd chpwd_update_git_vars
add-zsh-hook preexec preexec_update_git_vars
add-zsh-hook precmd precmd_update_git_vars

## Function definitions
function preexec_update_git_vars() {
    __EXECUTED_GIT_COMMAND=1
}

function precmd_update_git_vars() {
    if [ -n "$__EXECUTED_GIT_COMMAND" ] || [ -n "$ZSH_THEME_GIT_PROMPT_NOCACHE" ]; then
        update_current_git_vars
        unset __EXECUTED_GIT_COMMAND
    fi
}

function chpwd_update_git_vars() {
    update_current_git_vars
}

function update_current_git_vars() {
    unset __CURRENT_GIT_STATUS

    local out line oid
    local -a ab
    out=$(git status --porcelain=v2 --branch 2>/dev/null) || return

    __CURRENT_GIT_STATUS=1
    GIT_BRANCH=
    GIT_REMOTE=
    GIT_STAGED=0
    GIT_CONFLICTS=0
    GIT_CHANGED=0
    GIT_UNTRACKED=0

    for line in ${(f)out}; do
        case $line in
            ('# branch.oid '*) oid=${line#\# branch.oid } ;;
            ('# branch.head '*) GIT_BRANCH=${line#\# branch.head } ;;
            ('# branch.ab '*)
                ab=(${=line#\# branch.ab })
                (( ${ab[2]#-} )) && GIT_REMOTE+=" ↓${ab[2]#-}"
                (( ${ab[1]#+} )) && GIT_REMOTE+=" ↑${ab[1]#+}"
                ;;
            ([12]' '*)
                [[ ${line[3]} != . ]] && (( ++GIT_STAGED ))
                [[ ${line[4]} != . ]] && (( ++GIT_CHANGED ))
                ;;
            ('u '*) (( ++GIT_CONFLICTS )) ;;
            ('? '*) (( ++GIT_UNTRACKED )) ;;
        esac
    done

    [[ $GIT_BRANCH == '(detached)' ]] && GIT_BRANCH=":${oid[1,7]}"
    GIT_CLEAN=$(( !(GIT_STAGED + GIT_CONFLICTS + GIT_CHANGED + GIT_UNTRACKED) ))
}

git_super_status() {
    if [ -n "$__CURRENT_GIT_STATUS" ]; then

        ZSH_THEME_GIT_PROMPT_PREFIX=" "
        ZSH_THEME_GIT_PROMPT_SUFFIX=" "
        ZSH_THEME_GIT_PROMPT_SEPARATOR=" "
        ZSH_THEME_GIT_PROMPT_BRANCH=""
        ZSH_THEME_GIT_PROMPT_STAGED="%{$fg[red]%}●"
        ZSH_THEME_GIT_PROMPT_CONFLICTS="%{$fg[red]%}✖"
        ZSH_THEME_GIT_PROMPT_CHANGED="%{$fg[red]%}✚"
        ZSH_THEME_GIT_PROMPT_REMOTE=""
        ZSH_THEME_GIT_PROMPT_UNTRACKED="…"
        ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg[black]%}✔"
        reset_color=""

        STATUS="$ZSH_THEME_GIT_PROMPT_PREFIX$ZSH_THEME_GIT_PROMPT_BRANCH$GIT_BRANCH%{${reset_color}%}"
        if [ -n "$GIT_REMOTE" ]; then
                STATUS="$STATUS$ZSH_THEME_GIT_PROMPT_REMOTE$GIT_REMOTE%{${reset_color}%}"
        fi
        STATUS="$STATUS$ZSH_THEME_GIT_PROMPT_SEPARATOR"
        if [ "$GIT_STAGED" -ne "0" ]; then
                STATUS="$STATUS$ZSH_THEME_GIT_PROMPT_STAGED$GIT_STAGED%{${reset_color}%}"
        fi
        if [ "$GIT_CONFLICTS" -ne "0" ]; then
                STATUS="$STATUS$ZSH_THEME_GIT_PROMPT_CONFLICTS$GIT_CONFLICTS%{${reset_color}%}"
        fi
        if [ "$GIT_CHANGED" -ne "0" ]; then
                STATUS="$STATUS$ZSH_THEME_GIT_PROMPT_CHANGED$GIT_CHANGED%{${reset_color}%}"
        fi
        if [ "$GIT_UNTRACKED" -ne "0" ]; then
                STATUS="$STATUS$ZSH_THEME_GIT_PROMPT_UNTRACKED%{${reset_color}%}"
        fi
        if [ "$GIT_CLEAN" -eq "1" ]; then
                STATUS="$STATUS$ZSH_THEME_GIT_PROMPT_CLEAN"
        fi
        STATUS="$STATUS%{${reset_color}%}$ZSH_THEME_GIT_PROMPT_SUFFIX"
        echo  "$STATUS"
      fi
}

# Default values for the appearance of the prompt. Configure at will.
ZSH_THEME_GIT_PROMPT_PREFIX=" ["
ZSH_THEME_GIT_PROMPT_SUFFIX="]"
ZSH_THEME_GIT_PROMPT_SEPARATOR=";"
ZSH_THEME_GIT_PROMPT_BRANCH="%{$fg_bold[magenta]%}"
ZSH_THEME_GIT_PROMPT_STAGED="%{$fg[red]%}●"
ZSH_THEME_GIT_PROMPT_CONFLICTS="%{$fg[red]%}✖"
ZSH_THEME_GIT_PROMPT_CHANGED="%{$fg[blue]%}✚"
ZSH_THEME_GIT_PROMPT_REMOTE=""
ZSH_THEME_GIT_PROMPT_UNTRACKED="…"
ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg_bold[green]%}✔"
