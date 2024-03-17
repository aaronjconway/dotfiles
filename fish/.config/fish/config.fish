set fish_greeting ""
set fish_default_key_bindings

#calculator
alias calc 'bc -q'

#chat jipity
alias chat '~/development/playground/scripts/chat-jipity.sh'

#git log
alias gl "git log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset'"

#remote linode
alias admin-linode 'ssh aaron@172.235.62.214'

#open windows stuff
alias firefox 'wslview firfox'

#disk usage - file size
alias du 'du -h'

#linode command line
alias lcli 'linode-cli'

#sc - in term table editor. - not very good at using.
alias sc "sc-im"

#npm run dev -- --open
alias dev "npm run dev -- --open"

#kasey home loans one drive
alias ajcon 'cd /mnt/c/Users/ajcon/'

alias ls "exa -la"

#downloads folder on the
alias downloads 'cd /mnt/c/Users/ajcon/Downloads/'

#source fish
alias source_fish 'source ~/dotfiles/fish/.config/fish/config.fish'

#python
set -gx PYTHONPATH ~/development/playground/mmi $PYTHONPATH
alias python "python3"
alias py "python3"

# set colors for things
set -gx FZF_DEFAULT_OPTS '--border --margin=1 --padding=1 --layout=reverse --height 60% --color=hl+:#b83232,bg+:#FFE5B4,fg+:#282C34,gutter:-1'
set TERM 'xterm-256color'

#alias
alias nvim "/usr/local/bin/nvim"
alias vim "nvim"
alias v "nvim"
alias vd "nvim ."

## wsl term config
alias terminal_config "vim /mnt/c/Users/ajcon/AppData/Local/Packages/Microsoft.WindowsTerminal_8wekyb3d8bbwe/LocalState/settings.json"

alias startup "~/dotfiles/tmux/.config/tmux/startup.sh"

#ranger
set -gx RANGER_LOAD_DEFAULT_RC FALSE
alias r "ranger"

#windows files
alias windows  'cd /mnt/c/Users/ajcon'

#fish_config
alias fconfig "vim ~/dotfiles/fish/.config/fish/config.fish"

set -gx EDITOR "/usr/local/bin/nvim"
set -gx VISUAL "/usr/local/bin/nvim"

# Go
set -gx GOROOT '/usr/local/go'
set -x PATH $PATH /usr/local/go/bin
set -x GOPATH $HOME/go
set -x PATH $PATH $GOPATH/bin

set -gx PATH ~/.local/bin $PATH

set -x N_PREFIX "$HOME/n"; contains "$N_PREFIX/bin" $PATH; or set -a PATH "$N_PREFIX/bin"  # Added by n-install (see http://git.io/n-install-repo).

# Generated for envman. Do not edit.
test -s "$HOME/.config/envman/load.fish"; and source "$HOME/.config/envman/load.fish"

set -x N_PREFIX "$HOME/n"; contains "$N_PREFIX/bin" $PATH; or set -a PATH "$N_PREFIX/bin"  # Added by n-install (see http://git.io/n-install-repo).


# colored man output
# from http://linuxtidbits.wordpress.com/2009/03/23/less-colors-for-man-pages/
setenv LESS_TERMCAP_mb \e'[01;31m'       # begin blinking
setenv LESS_TERMCAP_md \e'[01;38;5;74m'  # begin bold
setenv LESS_TERMCAP_me \e'[0m'           # end mode
setenv LESS_TERMCAP_se \e'[0m'           # end standout-mode
setenv LESS_TERMCAP_so \e'[38;5;246m'    # begin standout-mode - info box
setenv LESS_TERMCAP_ue \e'[0m'           # end underline
setenv LESS_TERMCAP_us \e'[04;38;5;146m' # begin underline
