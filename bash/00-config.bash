# 00-config.bash
# ==================
# Set some configurations for bash(1)


# Dont save duplicate entries in history
HISTCONTROL=ignoredups:ignorespace

# Bash won't get SIGWINCH if another process is in the foreground.
# Enable checkwinsize so that bash will check the terminal size when
# it regains control.
# http://cnswww.cns.cwru.edu/~chet/bash/FAQ (E11)
shopt -s checkwinsize

# Enable history appending instead of overwriting.
shopt -s histappend

# Set history size
HISTSIZE=1000
HISTFILESIZE=2000
