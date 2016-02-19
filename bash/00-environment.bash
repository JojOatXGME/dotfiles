# 00-environment.bash
# ==================
# Change some environment variables like PATH


# Only run for login shell
[ "$LOGIN_SHELL_FIRST_BASH" ] || return


# Add $HOME/bin to PATH
# ----------------------------------------------------------------------

if [ -d "$HOME/bin" ]; then
	export PATH="$HOME/bin:$PATH"
fi

# Set editor
# ----------------------------------------------------------------------

export EDITOR='vim'
