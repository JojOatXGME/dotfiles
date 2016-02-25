# 50-aliases.bash
# ==================
# Create some aliases in bash(1)


# Enable colors in some commands.
alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

# Other ls aliases.
#alias ll='ls -alF'
#alias la='ls -A'
#alias l='ls -CF'

# Create some other aliases.
alias vi='vim'
alias view='vim -R'

# Add clipin and clipout to write from / read to clipboard.
alias clipin='xclip -i -selection clipboard'
alias clipout='xclip -o -selection clipboard'
