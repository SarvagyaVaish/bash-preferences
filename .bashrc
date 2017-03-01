export PATH=/usr/local/bin:/usr/local/sbin:$PATH

# ls colors
export LSCOLORS=gxBxhxDxfxhxhxhxhxcxcx
# export LSCOLORS=ExGxBxDxCxEgEdxbxgxcxd

# ls for mac
alias ls="ls -laFiGh"

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
export PS1="\u@\h \W\[\033[32m\]\$(parse_git_branch)\[\033[00m\] $ "


alias pi_recv="scp -r pi@192.168.0.119:~/TennisTracker/images ~/TTImages"
# alias pi_send="scp -r ~/TennisTracker pi@192.168.0.119:~/"

