#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias grep='grep --color=auto'

# PS1='[\u@\h \W]\$ '
PS1=' \W \$ '

export GPG_TTY=$(tty)

export PATH="$PATH:/home/zcchr/.cargo/bin"
export PATH="$PATH:/home/zcchr/.config/emacs/bin"
