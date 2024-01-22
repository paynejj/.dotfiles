# Setup fzf
# ---------
if [[ ! "$PATH" == */Users/josh/.config/programs/fzf/bin* ]]; then
  PATH="${PATH:+${PATH}:}/Users/josh/.config/programs/fzf/bin"
fi

# Auto-completion
# ---------------
source "/Users/josh/.config/programs/fzf/shell/completion.bash"

# Key bindings
# ------------
source "/Users/josh/.config/programs/fzf/shell/key-bindings.bash"
