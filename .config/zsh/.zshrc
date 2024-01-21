# Set zsh options
setopt histignorealldups sharehistory

# Use modern completion system
autoload -Uz compinit
compinit

# Get ssh agent from ubuntu keychain
if [ -d "$HOME/.keychain" ]; then 
	source $HOME/.keychain/$(hostname)-sh
fi

# Load antidote plugins
source $ZDOTDIR/.antidote/antidote.zsh
antidote load $ZDOTDIR/.zsh_plugins.txt

# Enable prompt (Should be last)
if command -v starship > /dev/null; then
	eval "$(starship init zsh)"
fi
