if [ -f ~/.bashrc ]; then
  . ~/.bashrc
fi

PATH=$PATH:$HOME/bin
export PATH

[[ -s "/Users/zefei/.rvm/scripts/rvm" ]] && source "/Users/zefei/.rvm/scripts/rvm"  # This loads RVM into a shell session.
rvm use 1.9.2
