### Added by Zinit's installer
if [[ ! -f $HOME/.local/share/zinit/zinit.git/zinit.zsh ]]; then
    print -P "%F{33} %F{220}Installing %F{33}ZDHARMA-CONTINUUM%F{220} Initiative Plugin Manager (%F{33}zdharma-continuum/zinit%F{220})…%f"
    command mkdir -p "$HOME/.local/share/zinit" && command chmod g-rwX "$HOME/.local/share/zinit"
    command git clone https://github.com/zdharma-continuum/zinit "$HOME/.local/share/zinit/zinit.git" && \
        print -P "%F{33} %F{34}Installation successful.%f%b" || \
        print -P "%F{160} The clone has failed.%f%b"
fi

source "$HOME/.local/share/zinit/zinit.git/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

# Load a few important annexes, without Turbo
# (this is currently required for annexes)
zinit light-mode for \
    zdharma-continuum/zinit-annex-as-monitor \
    zdharma-continuum/zinit-annex-bin-gem-node \
    zdharma-continuum/zinit-annex-patch-dl \
    zdharma-continuum/zinit-annex-rust
### End of Zinit's installer chunk

# Zsh Plugins
ZSH_AUTOSUGGEST_MANUAL_REBIND=1
zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions
zinit light Aloxaf/fzf-tab
NVM_COMPLETION=true
NVM_LAZY_LOAD=true
NVM_AUTO_USE=true
zinit wait lucid light-mode for lukechilds/zsh-nvm

# Load completions
autoload -Uz compinit bashcompinit
compinit
bashcompinit

# History
HISTSIZE=10000
HISTFILE=~/.zsh_history
SAVEHIST=$HISTSIZE
HISTDUP=erase
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups

# Completion styling
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu no
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'
zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'ls --color $realpath'

# Starship Prompt
eval "$(starship init zsh)"

# Integrations
eval "$(fzf --zsh)"
eval "$(zoxide init --cmd cd zsh)"

autoload -Uz up-line-or-beginning-search
autoload -Uz down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search
bindkey "^[[A" up-line-or-beginning-search
bindkey "^[[B" down-line-or-beginning-search

bindkey "^[[H" beginning-of-line
bindkey "^[[F" end-of-line
bindkey "^[[3~" delete-char

# Binary paths
path+=/home/antony/.local/bin
path+=/home/antony/.bun/bin
path+=/home/antony/.cargo/bin
path+=/home/antony/.yarn/bin
path+=/home/antony/.krew/bin
export PATH

# Aliases
#alias kubectl="HTTPS_PROXY=http://localhost:8888 kubectl"
alias k="kubectl"
#alias flux="HTTPS_PROXY=http://localhost:8888 flux"
alias j="just"
alias ls="eza -lah"

export EDITOR=nvim

# Kubectl TinyProxy
export KUBECONFIG=/home/antony/.kube/config:/home/antony/Development/di/local-kube-setup/config/dev-kubeconfig:/home/antony/Development/di/local-kube-setup/config/prod-kubeconfig
#export HTTPS_PROXY=http://localhost:8888
alias start_proxy='ssh -L 8888:localhost:8888 -N -q -f -J seed@jumpbox-di.tailb46562.ts.net ubuntu@172.16.0.7'


# The next line updates PATH for the Google Cloud SDK.
if [ -f '/home/antony/google-cloud-sdk/path.zsh.inc' ]; then . '/home/antony/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/home/antony/google-cloud-sdk/completion.zsh.inc' ]; then . '/home/antony/google-cloud-sdk/completion.zsh.inc'; fi

# bun completions
[ -s "/home/antony/.oh-my-zsh/completions/_bun" ] && source "/home/antony/.oh-my-zsh/completions/_bun"
