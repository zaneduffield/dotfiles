#!/bin/bash

export LANG=en_AU.UTF-8

export SHELL=$SHELL

export INPUTRC=~/dotfiles/.inputrc

. ~/dotfiles/.bash_completion.sh
. ~/dotfiles/.complete_alias.sh

. ~/dotfiles/.misc_scripts
. ~/dotfiles/.git_scripts

. ~/dotfiles/fzf/fzf.bash
. ~/dotfiles/bat.bash

complete_aliases() {
  complete -F _complete_alias "${!BASH_ALIASES[@]}"
}

complete_aliases