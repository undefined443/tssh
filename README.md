# tssh

A zsh function for connecting to a named tmux session on a remote host.

`tssh` selects the tmux integration mode from the current terminal:

- iTerm2 uses tmux Control Mode.
- All other terminals use a normal tmux client.

The default remote tmux session is the current local username.

## Dependencies

- zsh
- OpenSSH client
- tmux installed on the remote host

## Installation

### Manual

```zsh
git clone https://github.com/undefined443/tssh.git ~/.zsh/plugins/tssh
echo 'source ~/.zsh/plugins/tssh/tssh.plugin.zsh' >> ~/.zshrc
```

Restart zsh or load the plugin immediately:

```zsh
source ~/.zsh/plugins/tssh/tssh.plugin.zsh
```

### oh-my-zsh

```zsh
git clone https://github.com/undefined443/tssh.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/tssh
```

Add `tssh` to the `plugins=(...)` array in `~/.zshrc`.

### zinit

```zsh
zinit light undefined443/tssh
```

### antidote

```zsh
antidote bundle undefined443/tssh
```

## Usage

```zsh
# Connect to the session named after the current local username.
tssh example.com

# Connect to a named session.
tssh -s work user@example.com

# Pass SSH options before the host name.
tssh -p 2222 example.com
```

The `-s` option must appear before SSH options. All remaining arguments are passed directly to `ssh`.

## Troubleshooting

### Ghostty reports a missing or unsuitable terminal

If tmux on the remote host reports an error such as `missing or unsuitable terminal: xterm-ghostty`, the remote host does not have the Ghostty terminfo entry. Install it for the remote user from the local machine:

```zsh
infocmp -x xterm-ghostty | ssh example.com 'tic -x -o ~/.terminfo -'
```

Replace `example.com` with the target host. This preserves Ghostty terminal capabilities instead of falling back to a generic terminal type.

## License

MIT
