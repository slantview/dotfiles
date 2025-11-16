# Shell aliases

# Editor
export EDITOR="nvim"
export VISUAL="nvim"
alias vim="nvim"
alias vi="nvim"

# General
alias ll="ls -lah"
alias la="ls -la"
alias l="ls -l"
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."

# Git aliases (if not using git plugin)
alias gs="git status"
alias ga="git add"
alias gc="git commit"
alias gp="git push"
alias gl="git log"
alias gd="git diff"
alias gb="git branch"
alias gco="git checkout"

# Docker
alias d="docker"
alias dc="docker compose"
alias dcu="docker compose up"
alias dcd="docker compose down"
alias dps="docker ps"
alias dpsa="docker ps -a"

# Terraform
if command -v terraform &> /dev/null; then
  alias tf="terraform"
fi

# Kubernetes
if command -v kubectl &> /dev/null; then
  alias k="kubectl"
  alias kctx="kubectl config use-context"
fi

# Go
alias gob="go build"
alias got="go test"
alias gor="go run"

# Utilities
alias ug='uuidgen | tr "[:upper:]" "[:lower:]"'
alias grep="grep --color=auto"
alias fgrep="fgrep --color=auto"
alias egrep="egrep --color=auto"

# Enhanced tools (Omarchy style)
# eza - replacement for ls with more features
if command -v eza &> /dev/null; then
  alias ls="eza"
  alias lt="eza --tree --level=2"
  alias lsa="eza --all"
  alias lta="eza --tree --level=2 --all"
else
  # Fallback to standard ls
  if [[ "$IS_MACOS" == "true" ]]; then
    alias ls="ls -G"
  elif [[ "$IS_LINUX" == "true" ]] || [[ "$IS_WSL" == "true" ]]; then
    alias ls="ls --color=auto"
  fi
fi

