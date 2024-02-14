set -gx GOROOT '/usr/local/go'
set -gx RANGER_LOAD_DEFAULT_RC FALSE
set -gx PYTHONPATH ~/development/playground/mmi $PYTHONPATH
set fish_greeting ""

set fish_default_key_bindings

#chat jipity
alias chat '~/development/playground/scripts/chat-jipity.sh'

#chat jipity
alias gl "git log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset'"

#docker linode
alias docker-linode 'ssh aaron@172.233.155.179'

#attempting to open things with firefox
alias firefox 'wslview firfox'

#disk usage - file size
alias du 'du -h'

#linode command line
alias lcli 'linode-cli'

#sc - in term table editor. - not very good at using.
alias sc "sc-im"

#npm run dev -- --open
alias dev "npm run dev -- --open"

#obsidian git vault test
alias obsidian-git-vault-test 'cd /mnt/c/Users/ajcon/OneDrive/Git\ Vault\ Test/'

#kasey home loans one drive
alias ajcon 'cd /mnt/c/Users/ajcon/'

#tab for complete
alias ls "exa -la"

#run neovim in document mode
alias ndoc 'NVIM_APPNAME=nvim_document nvim'

#downloads folder on the
alias downloads 'cd /mnt/c/Users/ajcon/Downloads/'
#downloads folder on the
alias downloads 'cd /mnt/c/Users/ajcon/Downloads/'

#source fish
alias source_fish 'source ~/dotfiles/fish/.config/fish/config.fish'

# swap files
alias swp 'cd ~/.local/state/nvim/swap/'

#kasey home loans one drive
alias khl 'cd /mnt/c/Users/ajcon/OneDrive - Kasey Home Loans/'

#python
alias python "python3"
alias py "python3"

# set colors for things
set -gx FZF_DEFAULT_OPTS '--color=hl+:#b83232,bg+:#FFE5B4,fg+:#282C34,gutter:-1'
set TERM 'xterm-256color'

#alias
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
alias ts "tmux list"
alias tkeys "tmux list-keys | fzf"
alias startup "~/dotfiles/tmux/.config/tmux/startup.sh"

#ranger
alias r "ranger"

#kasey home loans onedrive
alias khl  'cd /mnt/c/Users/ajcon/OneDrive\ -\ Kasey\ Home\ Loans/'

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

set -x N_PREFIX "$HOME/n"; contains "$N_PREFIX/bin" $PATH; or set -a PATH "$N_PREFIX/bin"  # Added by n-install (see http://git.io/n-install-repo).
