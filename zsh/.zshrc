#vim ft=sh
case $- in *i*)
        [ -z "$TMUX" ] && exec tmux
esac

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

setopt share_history
setopt extended_history
setopt hist_ignore_all_dups
setopt hist_ignore_space
setopt hist_reduce_blanks
setopt hist_verify

autoload -Uz add-zsh-hook
zsh_history_sync() { fc -AI }
add-zsh-hook precmd zsh_history_sync

eval "$(dircolors -b)"
zstyle ':completion:*' auto-description 'specify: %d'
zstyle ':completion:*' completer _expand _complete _correct _approximate
zstyle ':completion:*' format 'Completing %d'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
zstyle ':completion:*' matcher-list '' 'm:{a-z}={A-Z}' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=* l:|=*'
zstyle ':completion:*' menu select=long
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
zstyle ':completion:*' use-compctl false
zstyle ':completion:*' verbose true
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*:git-checkout:*' sort false
zstyle ':completion::complete:*' cache-path ~/.zsh/cache
zstyle ':completion::complete:*' use-cache on
zstyle ':vcs_info:*' enable git
zstyle ':vcs_info:git*' formats "[%F{yellow}%b%f]"
zstyle ':vcs_info:git*:*' get-revision true

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
alias ..="cd .."
alias vim="nvim"

# for sway
export QT_QPA_PLATFORM=wayland
export GSK_RENDERER=ngl
export GDK_BACKEND=wayland
export WORDCHARS='*?_-.[]~=&;!#$%^(){}<>'
export KEYTIMEOUT=1
export LISTMAX=500
export FZF_CTRL_T_COMMAND=''
export FZF_DEFAULT_OPTS='--layout=reverse --height 40%'
export EDITOR="nvim"
export VISUAL="nvim"
export OPENER="xdg-open"

typeset -U path
path=($HOME/.local/bin /usr/local/go/bin $HOME/go/bin $HOME/cmus/bin $HOME/.config/emacs/bin $path)

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

## Define a Zsh widget that calls the function
zle -N my_dir dir
bindkey "^O" my_dir

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

export N_PREFIX="$HOME/n"; [[ :$PATH: == *":$N_PREFIX/bin:"* ]] || PATH+=":$N_PREFIX/bin"

eval "$(zoxide init zsh)"
