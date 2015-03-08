# Aliases
alias ll="ls -lh"
alias la="ls -la"
alias up="cd ..; ls -lh"

# Git
test -r /usr/local/etc/bash_completion.d/git-completion.bash && . /usr/local/etc/bash_completion.d/git-completion.bash
test -r /usr/local/etc/bash_completion.d/git-prompt.sh && . /usr/local/etc/bash_completion.d/git-prompt.sh
GIT_PS1_SHOWDIRTYSTATE=true

# Java
export JAVA_HOME=`/usr/libexec/java_home -v 1.8`

# Prompt
export PS1='\[\033[40;0;33m\]\W/ \[\033[40;1;32m\]$(__git_ps1)\[\033[0m\] $ '

# Path
export PATH=/usr/local/sbin:$PATH
