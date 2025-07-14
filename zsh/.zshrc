# Keybindings
bindkey -v
export KEYTIMEOUT=1

# History
HISTSIZE=100000000
SAVEHIST=100000000
HISTFILE=~/.zsh_history

setopt inc_append_history
setopt share_history
setopt extended_history
setopt hist_expire_dups_first
setopt hist_find_no_dups
setopt hist_ignore_dups
setopt hist_ignore_all_dups
setopt hist_ignore_space
setopt hist_reduce_blanks
setopt hist_save_no_dups
setopt hist_verify

autoload -Uz add-zsh-hook
zsh_history_sync() { fc -AI }
add-zsh-hook precmd zsh_history_sync

# Plugins via zgenom
source "${HOME}/.zgenom/zgenom.zsh"

if ! zgenom saved; then
    echo "Creating a zgenom save"

    zgenom load zsh-users/zsh-syntax-highlighting
    zgenom load zsh-users/zsh-completions
    zgenom load zsh-users/zsh-autosuggestions

    zgenom save
fi

# Completion system
autoload -Uz compinit
autoload -U colors && colors

zstyle ':completion:*' completer _complete _approximate
zstyle ':completion:*' completion-ignore-case true
zstyle ':completion:*' format '%B%d%b'
zstyle ':completion:*' insert-unambiguous true
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' list-columns 1
zstyle ':completion:*' list-packed false
zstyle ':completion:*' list-rows-first false
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}' 'r:|[._-]=**' 'l:|=* r:|=*'
zstyle ':completion:*' menu select
zstyle ':completion:*' select-prompt '%SScrolling active: %s'
zstyle ':completion:*:default' list-prompt '%S%M matches%s'
zstyle ':completion::complete:*' cache-path ~/.zsh/cache
zstyle ':completion::complete:*' use-cache on

_comp_options+=(globdots)
compinit -C

# Shell options
setopt autocd
setopt interactivecomments
setopt magicequalsubst
setopt nonomatch
setopt notify
setopt numericglobsort
setopt promptsubst

stty stop undef

# Time command formatting
TIMEFMT=$'\nreal\t%E\nuser\t%U\nsys\t%S\ncpu\t%P'

# Git prompt via vcs_info
autoload -Uz vcs_info
zstyle ':vcs_info:*' enable git
zstyle ':vcs_info:git*' formats "[%F{yellow}%b%f]"
zstyle ':vcs_info:git*:*' get-revision true
zstyle ':vcs_info:git*:*' check-for-changes false

precmd() { vcs_info }

# Prompt
PS1='${vcs_info_msg_0_} %~ $ '


# -----------------------------------------------------------------------------
# Alias's
# -----------------------------------------------------------------------------

alias grep="grep -i"


alias copy="xclip -selection clipboard"
alias bright='sudo brightnessctl set 120000'
alias capslock='xdotool key Caps_Lock'
alias CAPSLOCK='xdotool key Caps_Lock'

alias activate='source ~/py_envs/bin/activate'
alias ns='nix-shell'

alias caps='setxkbmap -option ctrl:nocaps'


domain() {
    while true; do
        read "input?>"
        whois "$input" | awk 'NR==1 { $1=$1; print }'
    done
}

alias s='source ~/.zshrc'

alias admin-linode='ssh root@172.235.38.138'


# call cheat sh for info
alias cheat='cheat_sh'

# rg search filenames
alias rgf="rg --files | rg -i"
alias rgi="rg -i"

alias ahk='cd /mnt/c/Users/ajcon/OneDrive/Documents/AutoHotkey/'


# alias python="python3"
# alias py="python3"
# used for webui:stable:diffusion:ai:image:generation

# ## testing temp
# alias python_cmd="python3.11"
# alias python="python3.11"
# alias python3="python3.11"


alias nvim="/usr/local/bin/nvim-linux-x86_64/bin/nvim"
alias vim="nvim"
alias vi="nvim"
alias vs="vim -c \"setlocal buftype=nofile bufhidden=hide noswapfile\""
alias supervim="sudo /usr/local/bin/nvim-linux-x86_64/bin/nvim"

alias startup="~/dotfiles/tmux/.config/tmux/startup.sh"

#cd into windows stuff
alias win='cd /mnt/c/Users/ajcon'

alias ls="ls -la --color=auto"

#Golang

# this is for libsqlite3, gcc and gclib having some conflict that produces and
# error - unsure of how to resolve

# export CGO_CFLAGS="-g -O2 -Wno-return-local-addr"
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

export EDITOR="/usr/local/bin/nvim-linux-x86_64/bin/nvim"
export VISUAL="/usr/local/bin/nvim-linux-x86_64/bin/nvim"
export PATH=$PATH:/usr/local/bin/nvim-linux-x86_64/bin/nvim
export OPENER="xdg-open"

# for making menu select in zsh only do 1 column
export COLUMNS=1

export FZF_DEFAULT_OPTS='--border --margin=1 --padding=1 --layout=reverse --height 60% --color=hl+:#b83232,bg+:#FFE5B4,fg+:#282C34,gutter:-1'
export TERM='xterm-256color'
export PATH="$HOME/.local/bin:$PATH"
export PAGER=less
export PATH="$HOME/Development/utils/:$PATH"

# change the word chars so that I can backspace to a /
export WORDCHARS='*?_-.[]~=&;!#$%^(){}<>'

export PATH=$HOME/.dotnet:$PATH
export PATH=$HOME/.dotnet/tools:$PATH
export DOTNET_ROOT=$HOME/.dotnet


if [ -x /usr/bin/dircolors ]; then

    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    export LS_COLORS="$LS_COLORS:ow=30;44:" # fix ls color for folders with 777 permissions

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
    zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
    zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'
fi

#----------------------------------------------------------
#-----------------------Functions--------------------------
#----------------------------------------------------------

reset-monitors() {
    primary="eDP-1"
    for output in $(xrandr | grep "con" | cut -d" " -f1); do
        xrandr --output "$output" --right-of "$primary"
        echo "$output" " set"
    done
}


laptop () {
        bright
        primary="eDP-1"
        for output in $(xrandr | grep "con" | cut -d" " -f1); do
                if [ "$output" = "$primary" ]; then
                        xrandr --output "$output" --auto
                else
                        xrandr --output "$output" --off
                fi
        done
}

monitors() {
    prev=""
    for output in $(xrandr | grep " connected" | cut -d" " -f1); do
        if [ -n "$prev" ]; then
            echo "setting $output right of $prev"
            xrandr --output "$output" --auto
            xrandr --output "$output" --right-of "$prev"
        fi
        prev="$output"
    done
}

mkd() {
  if [ -z "$1" ]; then
    echo "Usage: mkd <directory_name>"
    return 1
  fi
  mkdir -p "$1" && cd "$1"
}

# Use lf to cd into dirs

lfcd() {

    tmp="$(mktemp -uq)"
    trap 'rm -f $tmp >/dev/null 2>&1 && trap - HUP INT QUIT TERM PWR EXIT' HUP INT QUIT TERM PWR EXIT
    lf -last-dir-path="$tmp" "$@"

    if [ -f "$tmp" ]; then
        dir="$(cat "$tmp")"
        [ -d "$dir" ] && [ "$dir" != "$(pwd)" ] && cd "$dir"
    fi
}

h() {"$@" | batcat -p --theme="Visual Studio Dark+" --language=man }

# I would rather move these functions to a separate folder and pick from that
# folder. that way a new function would get automatically added to telesope
my_array=(
    directories
    directories_all
    readme
    project_directories
    find_root_dir
    files
    select_from_history
    obsidian
)

# Function to select from array using fzf
telescope() {
  local choice
  choice=$(printf "%s\n" "${my_array[@]}" | fzf --prompt="")
  $choice
}


directories() {
    local selected_dir
    selected_dir=$(fdfind . /home/aaron/ -E '.cargo' -E '.rust*' -E 'n' -E '.cache' -E '.dotnet' -E 'node_modules' -E '.git' -E 'dist' -E 'build' --type d |  fzf) && cd "$selected_dir" || return 1
    vcs_info
    zle reset-prompt
}


readme() {
    local selected_dir
    selected_dir=$(fdfind . . --type d | fzf --preview '[[ -f {}/README.md ]] && batcat {}/README.md || echo "README.md not found"') && cd "$selected_dir" || return 1

    # Final check and preview after selection
    if [[ -f "README.md" ]]; then
        batcat "README.md"
    else
        echo "README.md not found in the selected directory."
    fi
    vcs_info
    zle reset-prompt
}

directories_all() {
    local selected_dir
    selected_dir=$(fdfind . /home/aaron/ --hidden --type d |  fzf) && cd "$selected_dir" || return 1
    vcs_info
    zle reset-prompt
}

project_directories() {
    local selected_dir
    root_dir=$(find_root_dir)
    selected_dir=$(fdfind . $root_dir -E '.cargo' -E '.rust*' -E 'n' -E '.cache' -E '.config' -E '.dotnet' -E 'node_modules' -E '.git' -E 'dist' -E 'build' --type d |  fzf) && cd "$selected_dir" || return 1
    vcs_info
    zle reset-prompt
}

# a fzf function that helps find files only doesn't actuall go to them.
# this is for lf navigation.
project_files_for_lf() {
    root_dir=$(find_root_dir)
    selected_dir=$(fdfind . $root_dir --type d |  fzf)
    echo "$selected_dir"
    vcs_info
    zle reset-prompt
}

files() {
    local file
    file=$(fdfind . /home/aaron/ --hidden --type f |  fzf) && vim "$file" || return 1
    vcs_info
    zle reset-prompt
}

cheat_sh() {

    if [ "$#" -eq "" ]; then
        echo "Please provide an argument"
    else
        local url=$(echo "$*" | sed "s/ /%20/g")
        curl "cheat.sh/$url" | batcat --theme="Visual Studio Dark+" -p --color=always
    fi
    vcs_info
    zle reset-prompt
}

find_root_dir() {

    local file_list=(".git" "README.md")
    local current_dir="$PWD"

    #  while  the curredir is not the root dir
    while [[ "$current_dir" != "/home/aaron/" ]]; do
        for file in $file_list; do
            if [[ -e "$current_dir/$file" ]]; then
                echo "$current_dir"
                return 0
            fi
        done
        current_dir=$(dirname "$current_dir")
    done

    echo "Root directory not found."
    return 1
}


# Function to select and edit from command history using fzf
select_from_history() {
    local choice
    choice=$(history | fzf +s +m --tac --prompt="> " | awk '{$1=""; print substr($0,2)}')
    LBUFFER="$choice"
    zle redisplay
}

obsidian() {
    local selected_vault
    my_vaults=("KHL Vault" "Personal Vault" "Technology")
    selected_vault=$(printf '%s\n' "${my_vaults[@]}" | fzf) || return 1
    encoded_vault=$(echo "$selected_vault" | sed 's/ /%20/g')
    open "obsidian://open?vault=$encoded_vault"
    zle reset-prompt
}


#----------------------------------------------------------
#----------------------------------------------------------
#----------------------------------------------------------


bindkey -s '^G' '^ulazygit\n'

# Define a Zsh widget that calls the function
zle -N my_telescope telescope
bindkey "^O" my_telescope

bindkey '^H' backward-kill-word
bindkey '^?' backward-delete-char
bindkey '^p' up-line-or-history
bindkey '^n' down-line-or-history
bindkey '^e' autosuggest-accept
bindkey '^[[1;5D' backward-word
bindkey '^[[1;5C' forward-word
bindkey '^e' autosuggest-accept

bindkey '^I' expand-or-complete        # Tab
bindkey '^[[Z' reverse-menu-complete   # Shift-Tab


function zle-keymap-select {
  if [[ ${KEYMAP} == vicmd ]] ||
     [[ $1 = 'block' ]]; then
    echo -ne '\e[1 q'
  elif [[ ${KEYMAP} == main ]] ||
       [[ ${KEYMAP} == viins ]] ||
       [[ ${KEYMAP} = '' ]] ||
       [[ $1 = 'beam' ]]; then
    echo -ne '\e[5 q'
  fi
}

zle -N zle-keymap-select
zle-line-init() {
    zle -K viins
    echo -ne "\e[5 q"
}
zle -N zle-line-init
echo -ne '\e[5 q'

paste-from-clipboard() {
  LBUFFER+=$(xclip -o -selection clipboard)
  zle reset-prompt
}
zle -N paste-from-clipboard
bindkey -M vicmd 'v' paste-from-clipboard

# enable auto-suggestions based on the history
if [ -f /usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh ]; then
    . /usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh
    ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=#999'
fi


#------------------------------------------------------------------------------
# Generated for envman. Do not edit.
[ -s "$HOME/.config/envman/load.sh" ] && source "$HOME/.config/envman/load.sh"

# pnpm
export PNPM_HOME="/home/aaron/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

export N_PREFIX="$HOME/n"; [[ :$PATH: == *":$N_PREFIX/bin:"* ]] || PATH+=":$N_PREFIX/bin"  # Added by n-install (see http://git.io/n-install-repo).
