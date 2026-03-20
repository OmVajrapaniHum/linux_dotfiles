################################################################################
# BASHRC
# Author: Jakob Janzen
# Last Modified: 2026-03-20
#
# ~/.bashrc
################################################################################

case $- in
*i*) ;;
*) return ;;
esac

HISTCONTROL=ignoreboth
HISTSIZE=1000
HISTFILESIZE=2000

shopt -s autocd
shopt -s cdspell
shopt -s checkwinsize
shopt -s dirspell
shopt -s globstar
shopt -s histappend
shopt -s histverify

if [[ "$EUID" -eq 0 ]]; then
  PC="31"
else
  PC="32"
fi

export PS1="\[\e[01;${PC}m\]\u@\h\[\e[00m\]:\[\e[01;34m\]\w\[\e[01;${PC}m\]\\$ \[\e[0m\]"

if [[ -x /usr/bin/dircolors ]]; then
  eval "$(dircolors -b)"
  alias ls='ls --color=auto'
fi

if [[ -f ~/.bash_aliases ]]; then
  . ~/.bash_aliases
fi

if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

# Go Language Configuration - Managed by install_go.sh
export GOROOT=/usr/local/go
export GOPATH=$HOME/go
export PATH=$PATH:$GOROOT/bin:$GOPATH/bin
# End of Go Configuration
