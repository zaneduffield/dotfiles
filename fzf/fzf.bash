# Auto-completion
FZF_DIR=$(dirname -- "${BASH_SOURCE[0]}")

# ---------------
[[ $- == *i* ]] && {
  source "$FZF_DIR/completion.bash" &&
  source "$FZF_DIR/fzf-bash-completion.sh" &&
  bind -x '"\C-e": fzf_bash_completion'
}

# Key bindings
# ------------
source "$FZF_DIR/key-bindings.bash"
source "$FZF_DIR/custom.bash"
