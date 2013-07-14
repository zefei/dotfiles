if [ -f ~/.bashrc ]; then
  . ~/.bashrc
fi

export PATH=/usr/local/bin:/usr/local/sbin:/usr/local/share/python3:/usr/local/share/npm/bin:$PATH:$HOME/bin
export PATH=$PATH:/Library/android-sdk-macosx/platform-tools:/Library/android-sdk-macosx/tools
export RACK_ENV=development
export RAILS_ENV=development
export NODE_PATH=/usr/local/lib/node_modules
export NODE_ENV=development
export EDITOR=vim

eval "$(rbenv init -)"

if [ -f `brew --prefix`/etc/bash_completion ]; then
  . `brew --prefix`/etc/bash_completion
fi

alias grep='grep --color=auto'
alias ll='ls -lG'
alias l.='ls -dlG .*'
alias ls='ls -G'
alias mvim='mvim --remote-silent'
