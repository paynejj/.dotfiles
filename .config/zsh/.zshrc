# Set zsh options
setopt histignorealldups sharehistory

# Set control scheme to emacs 
bindkey -e

# Get ssh agent from ubuntu keychain
keychain=$HOME/.keychain/$(hostname)-sh
[ -f $keychain ] && source $keychain

# Load antidote plugins
source $ZDOTDIR/.antidote/antidote.zsh
antidote load $ZDOTDIR/.zsh_plugins.txt

# Fzf integration
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# Direnv integration
command -v direnv > /dev/null && eval "$(direnv hook zsh)"

# Fast Node Manager (FNM) integration
command -v fnm > /dev/null && eval "$(fnm env --use-on-cd)"

# Enable prompt (Should be last)
command -v starship > /dev/null && eval "$(starship init zsh)"
