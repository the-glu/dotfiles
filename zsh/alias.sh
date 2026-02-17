alias ls='ls --color=auto'
alias dir='ls --color=auto --format=vertical'
alias vdir='ls --color=auto --format=long'

alias ll='ls -l'
alias la='ls -A'
alias l='ls -CF'
alias vi=nvim

alias neovim='NVIM_TUI_ENABLE_TRUE_COLOR=1 konsole -e nvim &'
alias vim=nvim
alias cat=bat
alias agdj="ag --ignore-dir components/bower_components/ --ignore-dir static_source --ignore migrations"
alias megapush="git checkout master && git pull && git checkout deep && git pull && git merge master && git push && git push deep && git checkout pay && git pull && git merge master && git push && git push pay && git checkout services && git pull && git merge master && git push && git push abaservices"
alias pushtest="git checkout master && git pull && git checkout testing && git pull && git merge master && git push"
alias pushprod="git checkout master && git pull && git checkout prod && git pull && git merge master && git push"
alias batlim="sudo ectool fwchargelimit"

alias gpf="git bebeplanteforte --force"
alias btm="(git checkout master || git checkout main); git pull"

alias qrb='function _qrb() {
  local T="$1"
  local C=$(git rev-parse --abbrev-ref HEAD)

  if [ -z "$T" ]; then
    echo "Usage: qrb <branch>"; return 1
  fi

  if ! git rev-parse --verify "$T" >/dev/null 2>&1; then
    echo "Branch $T does not exist"; return 1
  fi

  git log --oneline "$C..$T"

  read "confirm?Reset branch $T to $C, keeping latest commit? [y/N] "
  if [[ ! "$confirm" =~ ^[Yy]$ ]]; then
    echo "Aborted"
    return 1
  fi

  local LAST_COMMIT=$(git rev-list "$C..$T" | head -n1)

  git branch -D "$T" || return 1
  git checkout -b "$T" || return 1
  git cherry-pick "$LAST_COMMIT"
}; _qrb'
