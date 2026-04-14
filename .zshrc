# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.


# Set the directory we want to store zinit and plugins
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"

# Download Zinit, if it's not there yet
if [ ! -d "$ZINIT_HOME" ]; then
   mkdir -p "$(dirname $ZINIT_HOME)"
   git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi

# Source/Load zinit
source "${ZINIT_HOME}/zinit.zsh"


# Add in zsh plugins
zinit ice wait"0" silent
zinit light zsh-users/zsh-syntax-highlighting
zinit ice wait"0" silent
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions
zinit ice wait"0" silent
zinit light Aloxaf/fzf-tab

# Add in snippets
zinit snippet OMZL::git.zsh
zinit snippet OMZP::git
zinit snippet OMZP::sudo
zinit snippet OMZP::archlinux
zinit snippet OMZP::aws
zinit snippet OMZP::conda
zinit snippet OMZP::kubectl
zinit snippet OMZP::kubectx
zinit snippet OMZP::command-not-found
zinit snippet OMZP::uv

# Load completions
autoload -Uz compinit && compinit

zinit cdreplay -q

if [[ ! -f ~/.cache/omp-init.zsh ]]; then
  oh-my-posh init zsh --config $HOME/.config/ohmyposh/zen.json > ~/.cache/omp-init.zsh
fi
source ~/.cache/omp-init.zsh

# Keybindings
bindkey -e
bindkey '^p' history-search-backward
bindkey '^n' history-search-forward
bindkey '^[w' kill-region

# History
HISTSIZE=5000
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

# Aliases
alias l="exa -l --icons --git -a"
alias lt="exa --tree --level=2 --long --icons --git"
alias ltree="exa --tree --level=2  --icons --git"
alias ls='exa -a --icons -F'
alias vim='nvim'
alias vi='nvim'
alias c='clear'
alias cat='bat'

# Shell integrations
eval "$(fzf --zsh)"
eval "$(zoxide init --cmd cd zsh)"
eval "$(direnv hook zsh)"
# VARIABLES
export GOBIN=/usr/local/go/bin
export PATH=$PATH:/usr/local/go/bin
export PATH=$PATH:/home/ishan/.cargo/bin
export EDITOR='nvim'
export BAT_THEME='Catppuccin Mocha'

export FZF_DEFAULT_OPTS=" \
--color=bg+:#000000,spinner:#f5e0dc,hl:#f38ba8 \
--color=fg:#cdd6f4,header:#f38ba8,info:#cba6f7,pointer:#f5e0dc \
--color=marker:#b4befe,fg+:#cdd6f4,prompt:#cba6f7,hl+:#f38ba8 \
--color=selected-bg:#000000 \
--multi"

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/home/ishan/miniconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/home/ishan/miniconda3/etc/profile.d/conda.sh" ]; then
        . "/home/ishan/miniconda3/etc/profile.d/conda.sh"
    else
        export PATH="/home/ishan/miniconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

# Yazi
function y() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
	yazi "$@" --cwd-file="$tmp"
	if cwd="$(command cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
		builtin cd -- "$cwd"
	fi
	rm -f -- "$tmp"
}
export CLOUDSDK_ROOT_DIR=/opt/google-cloud-cli
export CLOUDSDK_PYTHON=/usr/bin/python
export CLOUDSDK_PYTHON_ARGS='-S -W ignore'
export PATH=$CLOUDSDK_ROOT_DIR/bin:$PATH
export GOOGLE_CLOUD_SDK_HOME=$CLOUDSDK_ROOT_DIR
export FZF_DEFAULT_COMMAND='fd --exclude .venv --exclude .git --hidden'
export SCIRA_API_KEY=sk-scira-ruNmcGauJMCAszGeVhgkZnhEYpFCBNRiVXPYTDpxZTmGIforaQPgVRSJqPjSMrho

# nerdfetch -e
# rsftch

. "$HOME/.local/bin/env"
eval "$(uv generate-shell-completion zsh)"
eval "$(uvx --generate-shell-completion zsh)"


# if command -v tmux &> /dev/null && [ -n "$PS1" ] && [[ ! "$TERM" =~ screen ]] && [[ ! "$TERM" =~ tmux ]] && [ -z "$TMUX" ]; then
#   exec tmux
#   tmux source-file ~/.tmux.conf
# fi
#
#
# # Force underline cursor in tmux shells
# if [[ -n "$TMUX" ]]; then
#   PROMPT_COMMAND='printf "\e[4 q"'
#   # add-zsh-hook precmd _cursor_underline
# fi

# add-zsh-hook precmd _cursor_underline
# # Cursor shapes for Ghostty + tmux
# function _cursor_underline() {
#   printf '\e[4 q'
# }
#
# function _cursor_block() {
#   printf '\e[2 q'
# }
#
# # Shell idle → underline
# zle-line-init() {
#   _cursor_underline
# }
#
# # When command finishes / prompt redraws
# precmd() {
#   _cursor_underline
# }
#
# # Safety: on shell exit
# TRAPEXIT() {
#   _cursor_underline
# }


# ~/.daily_cowsay.sh
# printf "
#                  _-====-__-======-__-========-_____-============-__
#                _(                                                 _)
#             OO(           _/_ _  _  _/_   _/_ _  _  _/_           )_
#            0  (_          (__(_)(_) (__   (__(_)(_) (__            _)
#          o0     (_                                                _)
#         o         '=-___-===-_____-========-___________-===-dwb-='
#       .o                                _________
#      . ______          ______________  |         |      _____
#    _()_||__|| ________ |            |  |_________|   __||___||__
#   (         | |      | |            | __Y______00_| |_         _|
#  /-OO----OO""="OO--OO"="OO--------OO"="OO-------OO"="OO-------OO"=P
# ######################################################################
# "

# opencode
export PATH=/home/ishan/.opencode/bin:$PATH
export PATH=/home/ishan/dotfiles/bin:$PATH
export PATH=/home/ishan/.duckdb/cli/latest:$PATH

source ~/keys.sh

# Generated for envman. Do not edit.
[ -s "$HOME/.config/envman/load.sh" ] && source "$HOME/.config/envman/load.sh"
#compdef opencode
###-begin-opencode-completions-###
#
# yargs command completion script
#
# Installation: opencode completion >> ~/.zshrc
#    or opencode completion >> ~/.zprofile on OSX.
#
_opencode_yargs_completions()
{
  local reply
  local si=$IFS
  IFS=$'
' reply=($(COMP_CWORD="$((CURRENT-1))" COMP_LINE="$BUFFER" COMP_POINT="$CURSOR" opencode --get-yargs-completions "${words[@]}"))
  IFS=$si
  if [[ ${#reply} -gt 0 ]]; then
    _describe 'values' reply
  else
    _default
  fi
}
if [[ "'${zsh_eval_context[-1]}" == "loadautofunc" ]]; then
  _opencode_yargs_completions "$@"
else
  compdef _opencode_yargs_completions opencode
fi
###-end-opencode-completions-###


# Ctrl+G launcher
fzf_zoxide_widget() {
  local dir

  dir=$(
    {
      zoxide query -l

      fd -t d . ~/dotfiles ~/Desktop/programs ~/.config \
        --hidden --exclude .git --exclude .venv 2>/dev/null
    } | awk '!seen[$0]++' | fzf \
      --height 40% \
      --layout=reverse \
      --border \
      --preview 'eza --tree --level=2 --icons {} 2>/dev/null | head -200' \
      --preview-window=right:60% \
      --prompt="Jump to: "
  ) || return
  echo $dir

  builtin cd "$dir" || return
  zle accept-line
}

zle -N fzf_zoxide_widget
bindkey '^g' fzf_zoxide_widget
export PATH="$HOME/.local/share/coursier/bin:$PATH"
eval "$(cs java --jvm 17 --env)"
