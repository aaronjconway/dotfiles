bindkey -e
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
    zgenom load zsh-users/zsh-completions


    # save all to init script
    zgenom save
fi
# -----------------------------------------------------------------------------
###############################################################################
# -----------------------------------------------------------------------------

# The following lines were added by compinstall

autoload -Uz compinit
autoload -U colors && colors
autoload bashcompinit && bashcompinit
source /etc/bash_completion.d/azure-cli

compinit
compinit -d ~/.cache/zcompdump

zstyle ':completion:*' format '%B%d%b'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' insert-unambiguous true
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' list-prompt '%S%M matches%s'
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}' 'r:|[._-]=**' 'l:|=* r:|=*'
zstyle ':completion:*' menu select=2
zstyle ':completion:*' select-prompt '%SScrolling active: %s'
zstyle ':completion:*' list-prompt '%S%M matches%s'
zstyle ':completion:*' completer _complete _approximate
zstyle ':completion:*' completion-ignore-case true
autoload -U up-line-or-search down-line-or-search
zle -N up-line-or-search
zle -N down-line-or-search

zle -N autosuggest-or-complete
zle -A complete-word autosuggest-or-complete

zstyle :compinstall filename '/home/aaron/.zshrc'
_comp_options+=(globdots)		# Include hidden files.

plugins=(docker)

setopt autocd
setopt interactivecomments
setopt magicequalsubst
setopt nonomatch
setopt notify
setopt numericglobsort
setopt promptsubst
stty stop undef

# configure `time` format
TIMEFMT=$'\nreal\t%E\nuser\t%U\nsys\t%S\ncpu\t%P'

autoload -Uz vcs_info
setopt prompt_subst

precmd() {
    vcs_info
}

zstyle ':vcs_info:*' enable git
zstyle ':vcs_info:git*' formats "[%F{yellow}%b%f]"
zstyle ':vcs_info:git*:*' get-revision true
zstyle ':vcs_info:git*:*' check-for-changes false

PROMPT='${vcs_info_msg_0_}'
PS1="%F{blue}%n%f%F{yellow}@%f%F{green}%m%f$PROMPT %~ $ "

zsh_history_conf() {
    HISTSIZE=100000000        # Maximum number of events stored in memory
    SAVEHIST=100000000        # Maximum number of events saved to file
    HISTFILE=~/.zsh_history   # Where to save the history file
    HISTTIMEFORMAT="[%F %T] " # Include date and time in history entries

    setopt APPEND_HISTORY
    setopt EXTENDED_HISTORY
    setopt HIST_IGNORE_ALL_DUPS
    setopt HIST_FIND_NO_DUPS
    setopt HIST_IGNORE_SPACE
    setopt HIST_REDUCE_BLANKS
    setopt INC_APPEND_HISTORY
    setopt SHARE_HISTORY
    setopt NO_CASE_GLOB
}

zsh_history_conf

# -----------------------------------------------------------------------------
# Alias's
# -----------------------------------------------------------------------------
alias s='source ~/.zshrc'

alias admin-linode='ssh root@172.235.38.138'


# call cheat sh for info
alias cheat='cheat_sh'

# rg search filenames
alias rgf="rg . ~ --files | rg"

alias ahk='cd /mnt/c/Users/ajcon/OneDrive/Documents/AutoHotkey/'

alias python="python3"
alias py="python3"

# open go docs - idk how useful this is. kinda wanna port to typesense
alias godocs='wslview http://localhost:5555 && godoc -http=:5555 -v -index'

alias nvim="/usr/local/bin/nvim-linux64/bin/nvim"
alias vim="nvim"
alias vi="nvim"

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
export OPENER="wslview"
export FZF_DEFAULT_OPTS='--border --margin=1 --padding=1 --layout=reverse --height 60% --color=hl+:#b83232,bg+:#FFE5B4,fg+:#282C34,gutter:-1'
export TERM='xterm-256color'
export PATH="$HOME/.local/bin:$PATH"
export PAGER=less


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


mkd() {
  if [ -z "$1" ]; then
    echo "Usage: mkd <directory_name>"
    return 1
  fi
  mkdir -p "$1" && cd "$1"
}

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
    selected_dir=$(fdfind . /home/aaron/ -E '.cargo' -E '.rust*' -E 'n' -E '.cache' -E '.config' -E '.dotnet' -E 'node_modules' -E '.git' -E 'dist' -E 'build' --type d |  fzf) && cd "$selected_dir" || return 1
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

    zle reset-prompt
}

directories_all() {
    local selected_dir
    selected_dir=$(fdfind . /home/aaron/ --hidden --type d |  fzf) && cd "$selected_dir" || return 1
    zle reset-prompt
}

project_directories() {
    local selected_dir
    root_dir=$(find_root_dir)
    selected_dir=$(fdfind . $root_dir -E '.cargo' -E '.rust*' -E 'n' -E '.cache' -E '.config' -E '.dotnet' -E 'node_modules' -E '.git' -E 'dist' -E 'build' --type d |  fzf) && cd "$selected_dir" || return 1
    zle reset-prompt
}

# a fzf function that helps find files only doesn't actuall go to them.
# this is for lf navigation.
project_files_for_lf() {
    root_dir=$(find_root_dir)
    selected_dir=$(fdfind . $root_dir --type d |  fzf)
    echo "$selected_dir"
}

files() {
    local file
    file=$(fdfind . /home/aaron/ --hidden --type f |  fzf) && vim "$file" || return 1
    zle reset-prompt
}

cheat_sh() {

    if [ "$#" -eq "" ]; then
        echo "Please provide an argument"
    else
        local url=$(echo "$*" | sed "s/ /%20/g")
        curl "cheat.sh/$url" | batcat --theme="Visual Studio Dark+" -p --color=always
    fi
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

# open obsidian
alias obsidian='selected_vault'

selected_vault() {
    local selected_vault
    my_vaults=("KHL Vault" "Personal Vault")
    selected_vault=$(printf '%s\n' "${my_vaults[@]}" | fzf) || return 1
    encoded_vault=$(echo "$selected_vault" | sed 's/ /%20/g')
    wslview "obsidian://open?vault=$encoded_vault"
}

#----------------------------------------------------------
#----------------------------------------------------------
#----------------------------------------------------------

bindkey -s '^G' '^ulazygit\n'

# Define a Zsh widget that calls the function
zle -N my_telescope telescope
bindkey "^O" my_telescope

bindkey '^H' backward-kill-word
bindkey '^p' up-line-or-history
bindkey '^n' down-line-or-history
bindkey '^e' autosuggest-accept
bindkey '^[[1;5D' backward-word
bindkey '^[[1;5C' forward-word
bindkey '^e' autosuggest-accept

echo -ne '\e[5 q' # Use beam shape cursor on startup.
preexec() { echo -ne '\e[5 q' ;} # Use beam shape cursor for each new prompt.

# enable auto-suggestions based on the history
if [ -f /usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh ]; then
    . /usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh
    ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=#999'
fi

# Turso
export PATH="/home/aaron/.turso:$PATH"

# Generated for envman. Do not edit.
[ -s "$HOME/.config/envman/load.sh" ] && source "$HOME/.config/envman/load.sh"

# pnpm
export PNPM_HOME="/home/aaron/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end

export N_PREFIX="$HOME/n"; [[ :$PATH: == *":$N_PREFIX/bin:"* ]] || PATH+=":$N_PREFIX/bin"  # Added by n-install (see http://git.io/n-install-repo).


# add Pulumi to the PATH
export PATH=$PATH:/home/aaron/.pulumi/bin
