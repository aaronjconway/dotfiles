set fish_greeting ""

set -gx TERM xterm-256color

# theme
set -g theme_color_scheme terminal-dark
set -g fish_prompt_pwd_dir_length 1

# aliases
alias ls "ls -p -G"
alias la "ls -A"
alias ll "ls -l"
alias lla "ll -A"
alias g git
alias vim "/usr/local/nvim/bin/nvim"
alias nvim "/usr/local/nvim/bin/nvim"

# tmux binds 
alias t "tmux"
alias tk "tmux kill-session"
alias tv "tmux splitw -h"
alias ts "tmux  list"
alias tco "tmux list-commands | peco"
alias tkeys "tmux list-keys | peco"

set -gx EDITOR "/usr/local/nvim/bin/nvim"
set -gx VISUAL "/usr/local/nvim/bin/nvim"

# nvm
set -gx PATH /home/aaron/.local/share/nvm/v20.3.0/bin $PATH

# Go
set -g GOPATH $HOME/go
set -gx PATH $GOPATH/bin $PATH

switch (uname)
  case Darwin
    source (dirname (status --current-filename))/config-osx.fish
  case Linux
    source (dirname (status --current-filename))/config-linux.fish
  case '*'
    source (dirname (status --current-filename))/config-windows.fish
end

set LOCAL_CONFIG (dirname (status --current-filename))/config-local.fish
if test -f $LOCAL_CONFIG
  source $LOCAL_CONFIG
end


set PATH /home/aaron/.local/share/nvm/v20.3.0/bin/node $PATH
