export PATH=/usr/local/bin:/usr/local/sbin:$PATH

# ls colors
export LSCOLORS=gxBxhxDxfxhxhxhxhxcxcx
# export LSCOLORS=ExGxBxDxCxEgEdxbxgxcxd

# ls for mac
# alias ls="ls -laFiGh"
alias ls="exa -la --group-directories-first --sort Extension --git"
alias ll="ls"

# gitk showing all branches
alias gitkk="gitk --all &"

# virtual env wrapper for python
source `which virtualenvwrapper.sh`

# Bash completion
if [ -f $(brew --prefix)/etc/bash_completion ]; then
    . $(brew --prefix)/etc/bash_completion
fi

# Git branch in prompt.
parse_git_branch() {
    git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}
export PS1="\\[\e[0;36m\\]\u\\[\e[m\\] \W\[\033[32m\]\$(parse_git_branch)\[\033[00m\] $ "


alias pi_recv="scp -r pi@192.168.0.119:~/TennisTracker/images ~/TTImages"
# alias pi_send="scp -r ~/TennisTracker pi@192.168.0.119:~/"

alias st='git status'
alias br='git branch'
alias ad='git add -A'
alias cm='git commit -m'
alias b='cd ..'
alias bb='b && b'
alias bbb='bb && b'
alias gor='cd ~/Documents/cobalt_code/cobalt_behaviors/src'

alias subl='/Applications/Sublime\ Text.app/Contents/SharedSupport/bin/subl'

alias flushvpn='sudo ifconfig en0 down && sudo route flush && sudo ifconfig en0 up'
