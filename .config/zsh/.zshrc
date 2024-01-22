# Set zsh options
setopt histignorealldups sharehistory

# Set control scheme to emacs 
bindkey -e

# Get ssh agent from ubuntu keychain
if [ -d "$HOME/.keychain" ]; then 
	source $HOME/.keychain/$(hostname)-sh
fi

# Load antidote plugins
source $ZDOTDIR/.antidote/antidote.zsh
antidote load $ZDOTDIR/.zsh_plugins.txt

# Fzf integration
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# Enable prompt (Should be last)
if command -v starship > /dev/null; then
	eval "$(starship init zsh)"
fi
