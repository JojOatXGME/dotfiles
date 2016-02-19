# 50-tools.bash
# ==================
# Enables some tools if available.


# Make less more friendly for non-text input files, see lesspipe(1)
# ----------------------------------------------------------------------

[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# Enable advanced bash-completion
# ----------------------------------------------------------------------

if ! shopt -oq posix
then
	if [ -f "/etc/bash_completion" ]; then
		. "/etc/bash_completion"
	fi
	if [ -f "/opt/local/etc/profile.d/bash_completion.sh" ]; then
		. "/opt/local/etc/profile.d/bash_completion.sh"
	fi
	if [ -f "/usr/share/bash-completion/bash_completion" ]; then
		. "/usr/share/bash-completion/bash_completion"
	fi
fi

# Command not found hook
# ----------------------------------------------------------------------

if [ -f "/usr/share/doc/pkgfile/command-not-found.bash" ]; then
	. "/usr/share/doc/pkgfile/command-not-found.bash"
fi

# Add gem's stuff to path (ruby)
# ----------------------------------------------------------------------

if type ruby > /dev/null 2>&1 \
	&& [ -d "$(ruby -rubygems -e "puts Gem.user_dir")/bin" ]
then
	export PATH="$PATH:$(ruby -rubygems -e "puts Gem.user_dir")/bin"
fi
