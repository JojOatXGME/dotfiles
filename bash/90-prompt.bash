# 90-prompt.bash
# ==================
# Setup prompt for bash(1)


#PS1_chroot='${debian_chroot:+($debian_chroot)}'
PS1_line1='\[\e[1;3${PS1_COLOR1:-3}m\]\A : \[\e[0;3${PS1_COLOR1:-3}m\]\w\[\e[1;3${PS1_COLOR1:-3}m\] [\s:\#]\[$(PS1_scolor $?)\]<$?>'
PS1_line2='\[\e[1;3${PS1_COLOR2:-1}m\]\u@\h\$\[\e[0m\] '

PS1_scolor() {
	[ $1 -eq 0 ] || printf "\e[1;31m"
	return $1
}

export -f PS1_scolor
export PS1="${PS1_line1}\\n${PS1_line2}"
