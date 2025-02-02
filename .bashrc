#!/bin/bash

export LANG=en_AU.UTF-8

export SHELL=$SHELL

export INPUTRC=$DOTFILES/.inputrc

export EDITOR=vim

export PAGER='less -SFRX'

. "$DOTFILES"/.bash_completion.sh
. "$DOTFILES"/.complete_alias.sh

. "$DOTFILES"/.misc_scripts
. "$DOTFILES"/.git_scripts

. "$DOTFILES"/fzf/fzf.bash
. "$DOTFILES"/bat.bash

complete_aliases() {
  complete -F _complete_alias "${!BASH_ALIASES[@]}"
}

complete_aliases
