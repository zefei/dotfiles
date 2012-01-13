if [ -f ~/.bashrc ]; then
  . ~/.bashrc
fi

export PATH=/usr/local/bin:/usr/local/sbin:$PATH:$HOME/bin
export PYTHONPATH=/usr/local/lib/python2.7/site-packages:$PYTHONPATH
export NODE_PATH=/usr/local/lib/node_modules

[[ -s "/Users/zefei/.rvm/scripts/rvm" ]] && source "/Users/zefei/.rvm/scripts/rvm"  # This loads RVM into a shell session.

if [ -f `brew --prefix`/etc/bash_completion ]; then
  . `brew --prefix`/etc/bash_completion
fi
