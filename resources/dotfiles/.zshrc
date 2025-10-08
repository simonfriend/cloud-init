# HyperBEAM Development Environment ZSH Configuration

# Path to your oh-my-zsh installation
export ZSH="$HOME/.oh-my-zsh"

# Theme configuration
ZSH_THEME="powerlevel10k/powerlevel10k"

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Plugins
plugins=(
    git 
    zsh-autosuggestions 
    zsh-syntax-highlighting 
    you-should-use 
    zsh-bat
)

source $ZSH/oh-my-zsh.sh

# User configuration
export EDITOR='nvim'
export VISUAL='nvim'

# Aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
# alias vim='nvim'
# alias vi='nvim'

# Rust environment
if [[ -f "$HOME/.cargo/env" ]]; then
  source "$HOME/.cargo/env"
fi

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh