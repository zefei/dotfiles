# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# User specific aliases and functions
export TERM=xterm-256color
alias jasmine='jasmine-node --coffee'
