if [ -f ~/.bashrc ]; then
  . ~/.bashrc
fi

export PATH=/usr/local/bin:/usr/local/sbin:$PATH:$HOME/bin
export PYTHONPATH=/usr/local/lib/python2.7/site-packages:$PYTHONPATH
export RACK_ENV=development
export RAILS_ENV=development
export NODE_PATH=/usr/local/lib/node_modules
export NODE_ENV=development

eval "$(rbenv init -)"

if [ -f `brew --prefix`/etc/bash_completion ]; then
  . `brew --prefix`/etc/bash_completion
fi
