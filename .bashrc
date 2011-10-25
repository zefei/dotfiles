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
alias python32='VERSIONER_PYTHON_PREFER_32_BIT=yes python'
export EDITOR=vim
