# Connect to a remote tmux session with terminal-specific integration.

function tssh() {
  local session_name=$(id -un)
  local remote_session_name
  local tmux_command

  if [[ "$1" == '-s' ]]; then
    if [[ -z "$2" ]]; then
      echo 'usage: tssh [-s session_name] [ssh-args] hostname' >&2
      return 1
    fi
    session_name="$2"
    shift 2
  fi

  if [[ -z "$1" ]]; then
    echo 'usage: tssh [-s session_name] [ssh-args] hostname' >&2
    return 1
  fi

  remote_session_name=${(qqq)session_name}
  tmux_command="tmux new -A -s $remote_session_name"

  if [[ -n "${ITERM_SESSION_ID:-}" || "${TERM_PROGRAM:-}" == 'iTerm.app' ]]; then
    exec command ssh -t "$@" "tmux -CC new -A -s $remote_session_name"
  fi

  command ssh -t "$@" "$tmux_command"
}

if (( $+functions[compdef] )); then
  compdef tssh=ssh
fi
