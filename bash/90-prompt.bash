# 90-prompt.bash
# ==================
# Setup prompt for bash(1)


#PS1_chroot='${debian_chroot:+($debian_chroot)}'
PS1_line1='\[\033[1;33m\]\A : \[\033[0;33m\]\w\[\033[1;33m\] [\s:\#]$(PS1_exitcode $?)'
PS1_line2='\[\033[1;31m\]\u@\h\$\[\033[0m\] '

PS1_exitcode() {
	if [ $1 -ne 0 ]; then
		printf "\e[1;31m<$1>"
	else
		echo "<$1>"
	fi
}

export -f PS1_exitcode
export PS1="${PS1_line1}\\n${PS1_line2}"
