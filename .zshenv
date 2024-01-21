export XDG_CONFIG_HOME=$HOME/.config
# zsh does not follow xdg standard
export ZDOTDIR=$XDG_CONFIG_HOME/zsh
export PATH=$PATH:/usr/share

# rust tooling
if [ -d "$HOME/.cargo" ]; then 
  . "$HOME/.cargo/env"
fi 
