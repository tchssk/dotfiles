# Aliases
alias ll="ls -lh"
alias la="ls -la"
alias up="cd ..; ls -lh"

# Git
test -r /usr/local/etc/bash_completion.d/git-prompt.sh && . /usr/local/etc/bash_completion.d/git-prompt.sh
test -r /usr/local/etc/bash_completion.d/git-completion.bash && . /usr/local/etc/bash_completion.d/git-completion.bash
GIT_PS1_SHOWDIRTYSTATE=true

# Java
export JAVA_HOME=`/usr/libexec/java_home -v 1.8`

# Prompt
export PS1='\[\033[40;0;33m\]\W/ \[\033[40;1;32m\]$(__git_ps1)\[\033[0m\] $ '

# Path
export PATH=/usr/local/sbin:$PATH

# tmux
if [ -z "$TMUX" -a -z "$STY" ]; then
  if type tmuxx >/dev/null 2>&1; then
    tmuxx
  elif type tmux >/dev/null 2>&1; then
    if tmux has-session && tmux list-sessions | egrep -q '.*]$'; then
      tmux attach && echo "tmux attached session "
    else
      tmux new-session && echo "tmux created new session"
    fi
  elif type screen >/dev/null 2>&1; then
    screen -rx || screen -D -RR
  fi
fi
