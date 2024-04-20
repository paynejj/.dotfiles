autoload -Uz compinit
compinit

# Set zsh options
setopt histignorealldups sharehistory

# Set control scheme to emacs 
bindkey -e


# Load antidote plugins
source $ZDOTDIR/.antidote/antidote.zsh
antidote load $ZDOTDIR/.zsh_plugins.txt


# Direnv integration
command -v direnv > /dev/null && eval "$(direnv hook zsh)"

# Fzf integration
command -v fzf > /dev/null && eval "$(fzf --zsh)"

# Fast Node Manager (FNM) integration
command -v fnm > /dev/null && eval "$(fnm env --use-on-cd)"

# Zoxide integration (better cd)
command -v zoxide > /dev/null && eval "$(zoxide init zsh)"

# Enable prompt (Should be last)
command -v starship > /dev/null && eval "$(starship init zsh)"
