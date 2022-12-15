# GIT heart FZF
# -------------

is_in_git_repo() {
  git rev-parse HEAD &> /dev/null
}

export FZF_DEFAULT_COMMAND="git ls-files 2> /dev/null || \
  find -L . -mindepth 1 \\( -path '*/\\.*' -o -fstype 'sysfs' -o -fstype 'devfs' -o -fstype 'devtmpfs' -o -fstype 'proc' \\) -prune \
    -o -type f -print \
    -o -type d -print \
    -o -type l -print 2> /dev/null | cut -b3-"

export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND="${FZF_DEFAULT_COMMAND/git ls-files/git ls-files -co --directory | sed -E \'s|[^/]*$||\' | grep . | uniq -u}"

export GIT_FZF_DEFAULT_OPTS='--height 50% --min-height 20 --border --bind ctrl-/:toggle-preview'
FZF_GL_PREVIEW_COMMAND="gl"

git-fzf-widget() {
  local selected
  selected="$(FZF_DEFAULT_OPTS="$FZF_DEFAULT_OPTS $GIT_FZF_DEFAULT_OPTS" __fzf_select__)"
  if [ $# -gt 0 ]; then selected=$(echo "$selected" | eval "$@"); fi
  READLINE_LINE="${READLINE_LINE:0:$READLINE_POINT}$selected${READLINE_LINE:$READLINE_POINT}"
  READLINE_POINT=$(( READLINE_POINT + ${#selected} ))
}

_gd() {
  is_in_git_repo || return

  FZF_CTRL_T_COMMAND="git -c color.status=always status --short" \
  FZF_DEFAULT_OPTS="-m --ansi --nth 2..,.. --preview 'git diff --color=always -- {-1} | delta'" \
  git-fzf-widget
}

GB_FZF_CTRL_T_COMMAND="git branch -a --color=always | grep -v '/HEAD\s' | sort | sed 's/^..//'" \
GB_FZF_DEFAULT_OPTS="--ansi --multi --tac --preview-window right:70% --preview '$FZF_GL_PREVIEW_COMMAND {}'" \

_gb() {
  is_in_git_repo || return

  FZF_CTRL_T_COMMAND=$GB_FZF_CTRL_T_COMMAND \
  FZF_DEFAULT_OPTS=$GB_FZF_DEFAULT_OPTS \
  git-fzf-widget
}

_gcb() {
  is_in_git_repo || return

  local cmd branch
  FZF_CTRL_T_COMMAND=$GB_FZF_CTRL_T_COMMAND \
  FZF_DEFAULT_OPTS=$GB_FZF_DEFAULT_OPTS \
  branch=$(__fzf_select__) && [ "$branch" != "" ] && cmd="git checkout $branch" && echo "$cmd" && eval "$cmd"
}

_gt() {
  is_in_git_repo || return

  FZF_CTRL_T_COMMAND="git tag --sort -version:refname" \
  FZF_DEFAULT_OPTS="--multi --preview-window right:70% --preview '$FZF_GL_PREVIEW_COMMAND {}'" \
  git-fzf-widget
}

_gl() {
  is_in_git_repo || return

  local selected
  s='##' \
  FZF_CTRL_T_COMMAND="git log --color=always --date=relative -n 100 \
    --pretty=format:\"%C(yellow)%h$s%Cred%cd$s%C(cyan)%aN$s%Creset%s\" | \
    column --table --separator \"$s\" --output-separator \" \"" \
  FZF_DEFAULT_OPTS="--ansi --no-sort --reverse --multi --bind 'ctrl-s:toggle-sort' \
    --header 'Press CTRL-S to toggle sort' \
    --preview 'echo {} | grep -o "'"[a-f0-9]\{7,\}" | xargs git show --stat --color=always'"'" \
  git-fzf-widget "grep -oE '[a-f0-9]{7,}'"
}

_gs() {
  is_in_git_repo || return

  FZF_CTRL_T_COMMAND="git stash list" \
  FZF_DEFAULT_OPTS="--reverse -d: --nth 1 --preview '$FZF_GL_PREVIEW_COMMAND {1}'" \
  git-fzf-widget
}

if [[ $- =~ i ]]; then
  bind -x '"\eg": _gcb'

  bind -x '"\C-g\C-d": _gd'
  bind -x '"\C-g\C-b": _gb'
  bind -x '"\C-g\C-t": _gt'
  bind -x '"\C-g\C-l": _gl'

  # by default \C-s is bound to XON/XOFF flow control
  stty -ixon
  bind -x '"\C-g\C-s": _gs'
fi

