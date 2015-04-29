# Generic defaults
source ~/.zsh/generic.sh

# Completion
source ~/.zsh/completion.sh

# History
source ~/.zsh/history.sh

# Bind keys
source ~/.zsh/keys.sh

# Autoset terminal title
source ~/.zsh/title.sh

# Alias
source ~/.zsh/alias.sh

# Colored commands
source ~/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# Local parameters
if [ -f ~/.zsh/local.sh ]; then
    source ~/.zsh/local.sh
fi

# Git
if [[ "$ZSH_USE_GIT" == "yes" ]]; then
    source ~/.zsh/gitstatus.sh
fi

# Theme
source ~/.zsh/theme.sh
