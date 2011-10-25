if [ -f ~/.bashrc ]; then
  . ~/.bashrc
fi

PATH=$PATH:/usr/local/bin:/usr/local/sbin:$HOME/bin
export PATH
PYTHONPATH=/usr/local/lib/python2.7/site-packages:$PYTHONPATH
export PYTHONPATH

[[ -s "/Users/zefei/.rvm/scripts/rvm" ]] && source "/Users/zefei/.rvm/scripts/rvm"  # This loads RVM into a shell session.
rvm use 1.9.2

if [ -f `brew --prefix`/etc/bash_completion ]; then
  . `brew --prefix`/etc/bash_completion
fi
