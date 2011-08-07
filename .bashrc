# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# User specific aliases and functions
alias grep='grep --color=auto'
alias ll='ls -lG'
alias l.='ls -dG .*'
alias ls='ls -G'
export EDITOR=vim
