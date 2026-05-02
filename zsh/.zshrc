# Keybindings
bindkey -v
# export KEYTIMEOUT=1

# load zgenom
source "${HOME}/.zgenom/zgenom.zsh"

if ! zgenom saved; then

    zgenom load zsh-users/zsh-autosuggestions
    zgenom load zsh-users/zsh-completions
    zgenom load zsh-users/zsh-syntax-highlighting

    zgenom save
fi

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

zstyle ':completion:*' completer _complete _path_files _approximate
zstyle ':completion:*' completion-ignore-case true
zstyle ':completion:*' insert-unambiguous true
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}' 'r:|[._-]=**' 'l:|=* r:|=*'
zstyle ':completion:*' menu select
zstyle ':completion:*:git-checkout:*' sort false
zstyle ':completion::complete:*' cache-path ~/.zsh/cache
zstyle ':completion::complete:*' use-cache on

# Git prompt via vcs_info
zstyle ':vcs_info:*' enable git
zstyle ':vcs_info:git*' formats "[%F{yellow}%b%f]"
zstyle ':vcs_info:git*:*' get-revision true

# Shell options
setopt autocd
setopt interactivecomments
setopt magicequalsubst
setopt nonomatch
setopt notify
setopt numericglobsort
setopt promptsubst

stty stop undef

autoload -Uz vcs_info
precmd() { vcs_info }

# Prompt
PS1='${vcs_info_msg_0_} %~ $ '

_comp_options+=(globdots)

autoload -Uz compinit
compinit -C

alias copy="xclip -selection clipboard"
alias bright='sudo brightnessctl set 120000'
alias capslock='xdotool key Caps_Lock'
alias CAPSLOCK='xdotool key Caps_Lock'
alias vim="nvim"
alias vi="nvim"
alias python='python3'
alias lf='~/.config/lf/lf-ueberzug'

export FZF_CTRL_T_COMMAND=''
export FZF_DEFAULT_OPTS='--layout=reverse --height 40%'
export EDITOR="nvim"
export VISUAL="nvim"
export OPENER="xdg-open"
export MANWIDTH="80"
export DISPLAY=:0
export XAUTHORITY=$HOME/.Xauthority

typeset -U path
path=(/usr/local/go/bin $HOME/go/bin $path)

## change the word chars so that I can backspace to a /
export WORDCHARS='*?_-.[]~=&;!#$%^(){}<>'

my_array=(
    directories
    directories_all
    files
)

# Function to select from array using fzf
telescope() {
    local choice
    choice=$(printf "%s\n" "${my_array[@]}" | fzf --prompt="")
    $choice
    zle reset-prompt
}

directories() {
    local selected_dir
    selected_dir=$(fdfind . /home/aaron/ \
            -E .cargo -E '.rust*' -E go -E n -E .cache \
            -E .dotnet -E node_modules -E .git \
            -E dist -E build --type d |
        sed "s|$HOME|~|g" |
    fzf)

    [[ -z "$selected_dir" ]] && { zle reset-prompt; return 0; }

    selected_dir="${selected_dir/#\~/$HOME}"

    cd "$selected_dir" || return 1
    vcs_info
    zle reset-prompt
}

directories_all() {
    local selected_dir
    selected_dir=$(fdfind . /home/aaron/ --hidden --type d |  fzf) && cd "$selected_dir" || return 1
    vcs_info
    zle reset-prompt
}


files() {
    local file
    file=$(fdfind . /home/aaron/ --hidden --type f |  fzf) && vim "$file" || return 1
    vcs_info
    zle reset-prompt
}

## Define a Zsh widget that calls the function
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

# Beam = insert, Block = normal
function zle-keymap-select {
    if [[ $KEYMAP == vicmd ]]; then
        printf '\e[2 q'   # block cursor
    else
        printf '\e[6 q'   # beam cursor
    fi
}
zle -N zle-keymap-select

# Run on line init + force insert mode
function zle-line-init {
    zle -K viins       # start in insert mode
    printf '\e[6 q'    # ensure beam cursor
}
zle -N zle-line-init

# Optional: reset cursor on exit (so it doesn't stay block)
function zle-line-finish {
    printf '\e[6 q'
}
zle -N zle-line-finish


# pnpm
export PNPM_HOME="/home/aaron/.local/share/pnpm"
case ":$PATH:" in
    *":$PNPM_HOME:"*) ;;
    *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

export N_PREFIX="$HOME/n"; [[ :$PATH: == *":$N_PREFIX/bin:"* ]] || PATH+=":$N_PREFIX/bin"  # Added by n-install (see http://git.io/n-install-repo).

