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
