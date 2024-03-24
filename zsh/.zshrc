# -----------------------------------------------------------------------------
# load zgenom
# -----------------------------------------------------------------------------
source "${HOME}/.zgenom/zgenom.zsh"

# if the init scipt doesn't exist
if ! zgenom saved; then
    echo "Creating a zgenom save"

    # plugins
    zgenom load zsh-users/zsh-autosuggestions
    zgenom load zsh-users/zsh-syntax-highlighting
    zgenom load softmoth/zsh-vim-mode

    # # completions
    # zgen load zsh-users/zsh-completions src

    # save all to init script
    zgenom save
fi
# -----------------------------------------------------------------------------
###############################################################################
# -----------------------------------------------------------------------------

# The following lines were added by compinstall
zstyle :compinstall filename '/home/aaron/.config/shell/zshrc'


autoload -U colors && colors
zmodload zsh/complist
_comp_options+=(globdots)		# Include hidden files.

setopt autocd
#setopt correct
setopt interactivecomments
setopt magicequalsubst
setopt nonomatch
setopt notify
setopt numericglobsort
setopt promptsubst
stty stop undef

# enable completion features
autoload -Uz compinit
compinit -d ~/.cache/zcompdump
zstyle ':completion:*:*:*:*:*' menu select
zstyle ':completion:*' auto-description 'specify: %d'
zstyle ':completion:*' completer _expand _complete
zstyle ':completion:*' format 'Completing %d'
zstyle ':completion:*' group-name ''
# zstyle ':completion:*' list-colors ''
zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'
zstyle ':completion:*' rehash true
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
zstyle ':completion:*' use-compctl false
zstyle ':completion:*' verbose true
zstyle ':completion:*:kill:*' command 'ps -u $USER -o pid,%cpu,tty,cputime,cmd'


# configure `time` format
TIMEFMT=$'\nreal\t%E\nuser\t%U\nsys\t%S\ncpu\t%P'

autoload -Uz vcs_info
precmd() {
    vcs_info
}
zstyle ':vcs_info:*' enable git
zstyle ':vcs_info:git*' formats "[%F{yellow}%b%f]"

setopt prompt_subst

PROMPT='${vcs_info_msg_0_}'
PS1="%F{blue}%n%f%F{yellow}@%f%F{green}%m%f$PROMPT %~ $ "

# History
zsh_history_conf() {
    HISTSIZE=1000000
    SAVEHIST=1000000
    HISTFILE=${_SE_ZSH_HISTORY_LOCATION:=${ZDOTDIR:=$HOME}}/.zsh_history
    HISTTIMEFORMAT="[%F %T] "

    # ignore case when expanding PATH params
    setopt NO_CASE_GLOB

    #  History related
    #
    # Append to history, instead of replacing it.
    setopt APPEND_HISTORY
    # Save as : start time:elapsed seconds;command
    setopt EXTENDED_HISTORY
    # Do not store duplication's
    setopt HIST_IGNORE_ALL_DUPS
    # Do not add command line to history when the first character
    # on the line is a space, or when one of the expanded
    # aliases contains a leading space
    setopt HIST_IGNORE_SPACE

    # Filter out superfluous blanks
    setopt HIST_REDUCE_BLANKS

    # Waits until completion to save command to history. Without this, history
    # is saved as command starts, making elapsed time from EXTENDED_HISTORY
    # always being 0
    # Has no effect if SHARE_HISTORY is set
    setopt INC_APPEND_HISTORY_TIME
}

zsh_history_conf


# -----------------------------------------------------------------------------
# Alias's
# -----------------------------------------------------------------------------
alias s='source ~/.zshrc'

# rg search filenames
alias rgf="rg . ~ --files | rg"

alias ahk='cd /mnt/c/Users/ajcon/OneDrive/Documents/AutoHotkey/'

# alias python="python3"
# alias py="python3"

# open go docs - idk how useful this is. kinda wanna port to typesense
alias godocs='wslview http://localhost:5555 && godoc -http=:5555 -v -index'


# unset
alias r=""

alias nvim="/usr/local/bin/nvim-linux64/bin/nvim"
alias vim="nvim"
alias v="nvim"

alias startup="~/dotfiles/tmux/.config/tmux/startup.sh"

#cd into windows stuff
alias win='cd /mnt/c/Users/ajcon'

alias ls="exa -l"
alias la="exa -la"

#Golang
if [ -d /usr/local/go/bin/ ]; then
  export GOPATH=~/go
  export GOBIN="$GOPATH/bin"
  export PATH="/usr/local/go/bin:$GOBIN:$PATH"
elif [ -d ~/.go/bin/ ]; then
  export GOPATH="$HOME/.gopath"
  export GOROOT="$HOME/.go"
  export GOBIN="$GOPATH/bin"
  export PATH="$GOPATH/bin:$PATH"
fi

export EDITOR="/usr/local/bin/nvim-linux64/bin/nvim"
export VISUAL="/usr/local/bin/nvim-linux64/bin/nvim"

export FZF_DEFAULT_OPTS='--border --margin=1 --padding=1 --layout=reverse --height 60% --color=hl+:#b83232,bg+:#FFE5B4,fg+:#282C34,gutter:-1'

export TERM='xterm-256color'
# add local to path
export PATH="$HOME/.local/bin:$PATH"

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

# Use lf to cd into dirs
lfcd () {
    tmp="$(mktemp -uq)"
    trap 'rm -f $tmp >/dev/null 2>&1 && trap - HUP INT QUIT TERM PWR EXIT' HUP INT QUIT TERM PWR EXIT
    lf -last-dir-path="$tmp" "$@"
    if [ -f "$tmp" ]; then
        dir="$(cat "$tmp")"
        [ -d "$dir" ] && [ "$dir" != "$(pwd)" ] && cd "$dir"
    fi
}

my_array=(
    directories
    files
    select_from_history
    selected_vault
)


# Function to select from array using fzf
telescope() {
  local choice
  choice=$(printf "%s\n" "${my_array[@]}" | fzf --prompt="")
  $choice
}

directories() {
    local selected_dir
    selected_dir=$(fdfind . /home/aaron/ --hidden --type d |  fzf) && cd "$selected_dir" || return 1
    zle reset-prompt
}

files() {
    local file
    file=$(fdfind . /home/aaron/ --hidden --type f |  fzf) && vim "$file" || return 1
    zle reset-prompt
}


# Function to select and edit from command history using fzf
select_from_history() {
  local choice
  choice=$(history | fzf +s +m --tac --prompt="> " | awk '{$1=""; print substr($0,2)}')
    LBUFFER="$choice"
    zle redisplay
}

# open obsidian
alias obsidian='obsidian_open'

obsidian_open() {
    my_vaults=("KHL Vault" "Personal Vault")
    selected_vault=$(printf '%s\n' "${my_vaults[@]}" | fzf) || return 1
    encoded_vault=$(echo "$selected_vault" | sed 's/ /%20/g')
    wslview "obsidian://open?vault=$encoded_vault"
}

bindkey -s '^G' '^ulazygit\n'

# Define a Zsh widget that calls the function
zle -N my_telescope telescope
bindkey "^O" my_telescope


if [ -x /usr/bin/dircolors ]; then

    # test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    # export LS_COLORS="$LS_COLORS:ow=30;44:" # fix ls color for folders with 777 permissions

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'

    alias diff='diff --color=auto'
    alias ip='ip --color=auto'

    export LESS_TERMCAP_mb=$'\E[1;31m'     # begin blink
    export LESS_TERMCAP_md=$'\E[1;36m'     # begin bold
    export LESS_TERMCAP_me=$'\E[0m'        # reset bold/blink
    export LESS_TERMCAP_so=$'\E[01;33m'    # begin reverse video
    export LESS_TERMCAP_se=$'\E[0m'        # reset reverse video
    export LESS_TERMCAP_us=$'\E[1;32m'     # begin underline
    export LESS_TERMCAP_ue=$'\E[0m'        # reset underline

    # Take advantage of $LS_COLORS for completion as well
    # zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
    # zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'
fi

# enable auto-suggestions based on the history
if [ -f /usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh ]; then
    . /usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh
    ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=#999'
fi

# Turso
export PATH="/home/aaron/.turso:$PATH"


export N_PREFIX="$HOME/n"; [[ :$PATH: == *":$N_PREFIX/bin:"* ]] || PATH+=":$N_PREFIX/bin"

# Change cursor shape for different vi modes.
function zle-keymap-select () {
    case $KEYMAP in
        vicmd) echo -ne '\e[1 q';;      # block
        viins|main) echo -ne '\e[5 q';; # beam
    esac
}
zle -N zle-keymap-select
zle-line-init() {
    zle -K viins # initiate `vi insert` as keymap (can be removed if `bindkey -V` has been set elsewhere)
    echo -ne "\e[5 q"
}
zle -N zle-line-init
echo -ne '\e[5 q' # Use beam shape cursor on startup.
preexec() { echo -ne '\e[5 q' ;} # Use beam shape cursor for each new prompt.

# map
bindkey '^H' backward-kill-word
