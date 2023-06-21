
set fish_greeting ""

# aliases
alias ls "exa -la"

set TERM 'xterm-256color'

alias nvim "/usr/local/bin/nvim"
alias vim "nvim"
alias terminal_config "vim /mnt/c/Users/ajcon/AppData/Local/Packages/Microsoft.WindowsTerminal_8wekyb3d8bbwe/LocalState/settings.json"

# tmux binds 
alias t "tmux"
alias tk "tmux kill-session"
alias tv "tmux splitw -h"
alias ts "tmux  list"
alias tco "~/projects/playground/tmux_commands.sh"
alias tkeys "tmux list-keys | fzf"

#tree 
alias tra "tree -a -C -L 3"
alias tr "tree -C -L 3"

set -gx EDITOR "/usr/local/bin/nvim"
set -gx VISUAL "/usr/local/bin/nvim"

# Go
set -x -U GOPATH $HOME/go
set -gx PATH $GOPATH/bin $PATH

set -gx PATH ~/.local/bin $PATH

set -x N_PREFIX "$HOME/n"; contains "$N_PREFIX/bin" $PATH; or set -a PATH "$N_PREFIX/bin"  # Added by n-install (see http://git.io/n-install-repo).
