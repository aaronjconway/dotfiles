# The following lines were added by compinstall
zstyle :compinstall filename '/home/aaron/.config/shell/zshrc'

autoload -Uz compinit
compinit

# Enable colors and change prompt:
autoload -U colors && colors	# Load colors
PS1="%B%{$fg[red]%}[%{$fg[yellow]%}%n%{$fg[green]%}@%{$fg[blue]%}%M %{$fg[magenta]%}%~%{$fg[red]%}]%{$reset_color%}$%b "
setopt autocd		# Automatically cd into typed directory.
stty stop undef		# Disable ctrl-s to freeze terminal.
setopt interactive_comments

# History in cache directory:
HISTSIZE=10000000
SAVEHIST=10000000
HISTFILE="${XDG_CACHE_HOME:-$HOME/.cache}/zsh/history"

# Alias's
# -----------------------------------------------
alias source_zsh='source ~/.zshrc'
alias python="python3"
alias py="python3"
alias r=""


alias nvim="/usr/local/bin/nvim"
alias vim="nvim"
alias v="nvim"
alias vd="nvim ."
alias startup="~/dotfiles/tmux/.config/tmux/startup.sh"
alias windows='cd /mnt/c/Users/ajcon'

alias ls="exa -la"




export GOROOT='/usr/local/go'
export PATH=/usr/local/go/bin:$PATH
export GOPATH=$HOME/go
export PATH=$GOPATH/bin:$PATH
export EDITOR="/usr/local/bin/nvim"
export VISUAL="/usr/local/bin/nvim"
export FZF_DEFAULT_OPTS='--border --margin=1 --padding=1 --layout=reverse --height 60% --color=hl+:#b83232,bg+:#FFE5B4,fg+:#282C34,gutter:-1'
export TERM='xterm-256color'
export RANGER_LOAD_DEFAULT_RC=FALSE
export PATH=~/.local/bin:$PATH


# pretty man pages----------------------------------------
export LESS_TERMCAP_mb=$'\e[01;31m'       # begin blinking
export LESS_TERMCAP_md=$'\e[01;38;5;74m'  # begin bold
export LESS_TERMCAP_me=$'\e[0m'           # end mode
export LESS_TERMCAP_se=$'\e[0m'           # end standout-mode
export LESS_TERMCAP_so=$'\e[38;5;246m'    # begin standout-mode - info box
export LESS_TERMCAP_ue=$'\e[0m'           # end underline
export LESS_TERMCAP_us=$'\e[04;38;5;146m' # begin underline
#----------------------------------------------------------
#
# Basic auto/tab complete:
autoload -U compinit
zstyle ':completion:*' menu select
zmodload zsh/complist
compinit
_comp_options+=(globdots)		# Include hidden files.

# Use lf to switch directories and bind it to ctrl-o
lfcd () {
    tmp="$(mktemp -uq)"
    trap 'rm -f $tmp >/dev/null 2>&1 && trap - HUP INT QUIT TERM PWR EXIT' HUP INT QUIT TERM PWR EXIT
    lf -last-dir-path="$tmp" "$@"
    if [ -f "$tmp" ]; then
        dir="$(cat "$tmp")"
        [ -d "$dir" ] && [ "$dir" != "$(pwd)" ] && cd "$dir"
    fi
}

telescope () {

}

#--------------bind keys-----------------k
# bindkey -s '^o' '^ulfcd\n'
bindkey '^H' backward-kill-word

# Load syntax highlighting; should be last.
source /usr/share/zsh/plugins/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh 2>/dev/null
