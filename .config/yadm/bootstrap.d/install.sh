#! /bin/bash

# Define needed environment variables
[ -z "$XDG_CONFIG_HOME" ] && XDG_CONFIG_HOME=$HOME/.config
BOOTSTRAP_DIR="$(dirname "$(readlink -f "$0")")"
OS="$(uname -s)"
if [ "$OS" != "Linux" ]; then
	DISTRO="N/A"
elif command -v lsb_release >/dev/null; then
	DISTRO="$(lsb_release -si)"
else
	DISTRO="Unknown"
fi

# Source util functions
source "$BOOTSTRAP_DIR/../utils.sh"

# enable user input
exec </dev/tty
trap 'error_handler' ERR

# Report initial state
echo "System configuration..."
echo "OS=$OS"
echo "DISTRO=$DISTRO"
echo "HOME=$HOME"
echo "XDG_CONFIG_HOME=$XDG_CONFIG_HOME"
echo "BOOTSTRAP_DIR=$BOOTSTRAP_DIR"

if [ "$OS" == "Linux" ] && [ "$DISTRO" == "Unknown" ]; then
	user_confirmation "This install script is intended for MacOS and Ubuntu. Continue?"
fi

# Install Package Manager and/or programs
user_confirmation "I need to use sudo to install some packages, is that ok?"
sudo echo "Sudo Access Granted!"
if [ "$OS" == "Darwin" ]; then
	# Ensure curl is installed
	check_prerequisites "curl"
	# Install Homebrew
	echo "Installing Homebrew"
	echo "NONINTERACTIVE=1 /bin/bash -c \"\$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)\""
	NONINTERACTIVE=1 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
	echo "Installed Homebrew!"

	# Install brewfile
	eval "$(/opt/homebrew/bin/brew shellenv)"
	echo "Installing brewfile"
	echo "brew bundle install --global"
	brew bundle install --global
else
	# Install via apt
	echo "sudo apt update && sudo apt install zsh build-essential cmake ninja-build gettext unzip curl -y"
	sudo apt update && sudo apt install zsh build-essential cmake ninja-build gettext unzip curl -y
	# Install lazygit
	LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | grep -Po '"tag_name": "v\K[^"]*')
	curl -Lo lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/latest/download/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz"
	tar xf lazygit.tar.gz lazygit
	sudo install lazygit /usr/local/bin
fi

# Install Rust
cd "$HOME" || exit 1
echo "Installing Rust toolchain..."
echo "curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y"
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y

# Install Rust crates
echo "Intalling crates..."
echo "source $HOME/.cargo/env"
source "$HOME/.cargo/env"
echo "cargo install bat bottom eza fd-find fnm ripgrep starship zoxide"
cargo install bat bottom eza fd-find fnm ripgrep starship

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

echo "yadm bootstrap success!"
echo "restart your shell to have full functionality"
