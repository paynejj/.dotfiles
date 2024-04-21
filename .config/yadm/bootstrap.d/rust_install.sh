# Install Rust
if command -v rustup >/dev/null; then
	echo "Rust toolchain already installed"
else
	echo "Installing Rust toolchain..."
	echo "curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y"
	curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
fi

# Install Rust crates
echo "Intalling crates..."
echo "source $HOME/.cargo/env"
source "$HOME/.cargo/env"
echo "cargo install bat bottom eza fd-find fnm ripgrep starship zoxide"
cargo install bat bottom eza fd-find fnm ripgrep starship zoxide
