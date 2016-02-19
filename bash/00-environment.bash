# 00-environment.bash
# ==================
# Change some environment variables like PATH


export EDITOR='vim'

if [ -d "$HOME/bin" ]; then
	export PATH="$HOME/bin:$PATH"
fi
