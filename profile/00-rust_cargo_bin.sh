# 00-rust_cargo_bin.sh
# ====================
# Add local executables of cargo/rust to PATH

if [ -d "$HOME/.cargo/bin" ]; then
	export PATH="$PATH:$HOME/.cargo/bin"
fi
