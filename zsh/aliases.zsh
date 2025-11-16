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
# Always define k() function - it will check for kubectl at runtime
# Lazy-load kubeconfig if load_kubeconfig function exists (from .zshrc_local)
k() {
  if ! command -v kubectl &> /dev/null; then
    echo "Error: kubectl is not installed or not in PATH" >&2
    return 1
  fi
  
  # Lazy-load kubeconfig if the function exists
  if typeset -f load_kubeconfig > /dev/null; then
    load_kubeconfig
  fi
  
  kubectl "$@"
}

# kubectl context switching alias (only if kubectl is available)
if command -v kubectl &> /dev/null; then
  alias kctx="kubectl config use-context"
  alias kns="kubectl config set-context --current --namespace"
fi

# k9s - Kubernetes CLI to manage clusters
if command -v k9s &> /dev/null; then
  alias k9="k9s"
fi

# helm - Kubernetes package manager
if command -v helm &> /dev/null; then
  alias h="helm"
fi

# stern - Multi pod and container log tailing
if command -v stern &> /dev/null; then
  alias klogs="stern"
fi

# kubectx/kubens - Context and namespace switching (if installed)
if command -v kubectx &> /dev/null; then
  alias kx="kubectx"
fi
if command -v kubens &> /dev/null; then
  alias kn="kubens"
fi

# kubectl-tree - Show object hierarchy (if installed as kubectl plugin)
if command -v kubectl-tree &> /dev/null; then
  alias ktree="kubectl tree"
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

