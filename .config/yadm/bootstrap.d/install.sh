#! /bin/bash

# Get the path to bootstrap.d
script_dir="$(dirname "$(readlink -f "$0")")"
source "$script_dir/../utils.sh"
source "$HOME/.zshenv"

check_prerequisites "curl" "cmake"

# Initialize Submodules
cd "$HOME" || exit 1
echo "Initializing submodules..."
echo "yadm submodule update --init"
yadm submodule update --init
echo "Initialized submodules!"

# Install fzf
cd "$XDG_CONFIG_HOME/programs/fzf" || exit 1
if [ ! -e "$XDG_CONFIG_HOME/fzf/fzf.zsh" ]; then
	if [ ! -x ./install ]; then
		echo "Fzf install script not found or executable!"
		exit 1
	fi
	echo "Installing fzf..."
	echo "./install --xdg --no-update-rc --key-bindings --completion"
	./install --xdg --no-update-rc --key-bindings --completion
	echo "Installed fzf!"
else
	echo "Fzf install detected!"
fi

# Install Rust
cd "$HOME" || exit 1
echo "Installing Rust toolchain..."
echo "curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh"
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

# Install Rust crates
echo "Intalling crates..."
echo "source $HOME/.cargo/env"
source "$HOME/.cargo/env"
echo "cargo install bat bottom eza fd-find fnm ripgrep starship"
cargo install bat bottom eza fd-find fnm ripgrep starship

if [ "$(uname -s)" == "Darwin" ]; then
	# Install Homebrew
	echo "Installing Homebrew"
	echo "NONINTERACTIVE=1 /bin/bash -c \"\$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)\""
	NONINTERACTIVE=1 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
	echo "Installed Homebrew!"

	# Install brewfile
	eval "$(brew shellenv)"
	echo "Installing brewfile"
	echo "brew bundle install"
	brew bundle install
fi

echo "yadm bootstrap success!"
echo "restart your shell to have full functionality"
