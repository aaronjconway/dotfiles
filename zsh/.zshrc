#vim ft=sh
case $- in *i*)
        [ -z "$TMUX" ] && exec tmux
  esac

bindkey -v

source "${HOME}/.zgenom/zgenom.zsh"

if ! zgenom saved; then
    zgenom load zsh-users/zsh-autosuggestions
    zgenom load zsh-users/zsh-completions
    zgenom load zsh-users/zsh-syntax-highlighting
    zgenom save
fi

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

eval "$(dircolors -b)"

zstyle ':completion:*' completer _complete _files _approximate
zstyle ':completion:*' group-name ''
zstyle ':completion:*:descriptions' format '%F{green}%d%f'
zstyle ':completion:*:corrections' format '%F{yellow}%d (errors: %e)%f'
zstyle ':completion:*:messages' format ' %F{purple}%d%f'
zstyle ':completion:*:warnings' format ' %F{red}no matches found%f'
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' verbose yes
zstyle ':completion:*' menu select
zstyle ':completion:*' completion-ignore-case true
zstyle ':completion:*' file-patterns '*:all-files'
zstyle ':completion:*' insert-unambiguous true
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}' 'r:|[._-]=**' 'l:|=* r:|=*'
zstyle ':completion:*:git-checkout:*' sort false
zstyle ':vcs_info:*' enable git
zstyle ':vcs_info:git*' formats "[%F{yellow}%b%f]"
zstyle ':vcs_info:git*:*' get-revision true
zstyle ':completion::complete:*' cache-path ~/.zsh/cache
zstyle ':completion::complete:*' use-cache on

setopt autocd
setopt interactivecomments
setopt magicequalsubst
setopt nonomatch
setopt notify
setopt numericglobsort
setopt promptsubst
setopt globdots
stty stop undef

autoload -Uz vcs_info
precmd() { vcs_info }

PS1='${vcs_info_msg_0_} %~ $ '

autoload -Uz compinit
compinit -C

alias copy="wl-copy"
alias cd="z"
alias vim="nvim"

# for sway
export QT_QPA_PLATFORM=wayland
export GSK_RENDERER=ngl
export GDK_BACKEND=wayland

export KEYTIMEOUT=1
export LISTMAX=500
export FZF_CTRL_T_COMMAND=''
export FZF_DEFAULT_OPTS='--layout=reverse --height 40%'
export EDITOR="nvim"
export VISUAL="nvim"
export OPENER="xdg-open"

typeset -U path
path=($HOME/.local/bin /usr/local/go/bin $HOME/go/bin $HOME/cmus/bin $HOME/.config/emacs/bin $path)

my_array=(
    directories
    directories_all
    files
)

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

vpn() {
    local cmd="$1"
    local output=""
    local file="/tmp/swaybar.fifo"

    case "$cmd" in
        "up")
            output=$(protonvpn connect 2>&1)
            ;;
        "down")
            output=$(protonvpn disconnect 2>&1)
            ;;
        "info")
            output=$(protonvpn status 2>&1)
            ;;
        *)
            echo "Usage: vpn {up|down|info}"
            return 1
            ;;
    esac

    if [ -p "$file" ]; then
        echo "$output" > "$file"
    fi
}

lfm-search () {
    if [ -z "$1" ]; then
        echo "Error: Missing artist name." >&2
        echo "Usage: lfm-search \"Artist Name\"" >&2
        return 1
    fi

    local artist="$1"
    local api_key="8bb0050df47bc66ff2c41a4144f5eacd"

    curl -s -G "http://ws.audioscrobbler.com/2.0/" \
        --data-urlencode "method=artist.gettopalbums" \
        --data-urlencode "artist=$artist" \
        --data-urlencode "api_key=$api_key" \
        --data-urlencode "format=json" | \
        jq -r '.topalbums as $ta | $ta["@attr"].artist, ($ta.album | sort_by(.playcount | tonumber) | reverse | .[] | "\(.name),\(.playcount)")'
}

function select-to-last-prompt() {
    local prompt_text

    # must strip ansi
    prompt_text=$(
        print -P "$PS1" |  sed $'s/\x1b\\[[0-9;]*[[:alpha:]]//g'
    )

    tmux copy-mode
    tmux send-keys -X begin-selection
    tmux send-keys -X search-backward-text "$prompt_text"
    tmux send-keys -X "n"
}

zle -N select-to-last-prompt
bindkey '^y' select-to-last-prompt

## Define a Zsh widget that calls the function
zle -N my_telescope telescope
bindkey "^O" my_telescope

bindkey '^?' backward-delete-char
bindkey '^H' backward-kill-word
bindkey '^[[1;5C' forward-word
bindkey '^[[1;5D' backward-word
bindkey '^I' expand-or-complete        # Tab
bindkey '^[[Z' reverse-menu-complete   # Shift-Tab
bindkey '^e' autosuggest-accept
bindkey '^n' down-line-or-history
bindkey '^p' up-line-or-history

function zle-keymap-select {
    if [[ $KEYMAP == vicmd ]]; then
        printf '\e[2 q'
    else
        printf '\e[6 q'
    fi
}
zle -N zle-keymap-select

function zle-line-init {
    zle -K viins
    printf '\e[6 q'
}
zle -N zle-line-init

function zle-line-finish {
    printf '\e[6 q'
}
zle -N zle-line-finish

export PNPM_HOME="/home/aaron/.local/share/pnpm"
case ":$PATH:" in
    *":$PNPM_HOME:"*) ;;
    *) export PATH="$PNPM_HOME:$PATH" ;;
esac

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

export N_PREFIX="$HOME/n"; [[ :$PATH: == *":$N_PREFIX/bin:"* ]] || PATH+=":$N_PREFIX/bin"

eval "$(zoxide init zsh)"
