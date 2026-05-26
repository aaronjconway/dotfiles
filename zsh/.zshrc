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
alias bright='sudo brightnessctl set 120000'
alias vim="nvim"
alias vi="nvim"
alias python='python3'



export KEYTIMEOUT=1
export LISTMAX=500
export FZF_CTRL_T_COMMAND=''
export FZF_DEFAULT_OPTS='--layout=reverse --height 40%'
export EDITOR="nvim"
export VISUAL="nvim"
export OPENER="xdg-open"
export MANWIDTH="80"
export LESS_TERMCAP_mb=$'\e[1;31m'     # begin bold
export LESS_TERMCAP_md=$'\e[1;33m'     # begin blink
export LESS_TERMCAP_so=$'\e[01;44;37m' # begin reverse video
export LESS_TERMCAP_us=$'\e[01;37m'    # begin underline
export LESS_TERMCAP_me=$'\e[0m'        # reset bold/blink
export LESS_TERMCAP_se=$'\e[0m'        # reset reverse video
export LESS_TERMCAP_ue=$'\e[0m'        # reset underline
export GROFF_NO_SGR=1                  # for konsole and gnome-terminal
export MANPAGER='less -s -M +Gg'
export WORDCHARS='*?_-.[]~=&;!#$%^(){}<>'

typeset -U path
path=($HOME/.local/bin /usr/local/go/bin $HOME/go/bin $path)

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
