
set fish_greeting ""

alias la "exa -la"

set TERM 'xterm-256color'

# set fzf background color
set -gx FZF_DEFAULT_OPTS '--color=hl+:#b83232,bg+:#FFE5B4,fg+:#282C34,gutter:-1'

alias nvim "/usr/local/bin/nvim"
alias vim "nvim"
alias v "nvim"
alias vd "nvim ."

## wsl term config
alias terminal_config "vim /mnt/c/Users/ajcon/AppData/Local/Packages/Microsoft.WindowsTerminal_8wekyb3d8bbwe/LocalState/settings.json"

#look for any man page
alias manlist "source ~/dotfiles/fish/.config/fish/functions/fzf_select_man.fish"

# tmux binds 
alias t "tmux"
alias tk "tmux kill-session"
alias tv "tmux splitw -h"
alias ts "tmux  list"
alias tkeys "tmux list-keys | fzf"
alias ratehawk "~/development/playground/scripts/ratehawk_dev.sh"

#ranger
alias r "ranger" 

#fish_config
alias fconfig "vim ~/dotfiles/fish/.config/fish/config.fish"

#tree 
alias tra "tree -a -C -L 3"
alias tr "tree -C -L 3"

set -gx EDITOR "/usr/local/bin/nvim"
set -gx VISUAL "/usr/local/bin/nvim"

# Go

set -x PATH $PATH /usr/local/go/bin
set -x GOPATH $HOME/go
set -x PATH $PATH $GOPATH/bin

set -gx PATH ~/.local/bin $PATH

set -x N_PREFIX "$HOME/n"; contains "$N_PREFIX/bin" $PATH; or set -a PATH "$N_PREFIX/bin"  # Added by n-install (see http://git.io/n-install-repo).

# Generated for envman. Do not edit.
test -s "$HOME/.config/envman/load.fish"; and source "$HOME/.config/envman/load.fish"
