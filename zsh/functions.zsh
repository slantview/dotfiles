# Custom shell functions

# Create a directory and cd into it
mkcd() {
  mkdir -p "$1" && cd "$1"
}

# Extract various archive formats
extract() {
  if [[ -f "$1" ]]; then
    case "$1" in
      *.tar.bz2)   tar xjf "$1"     ;;
      *.tar.gz)    tar xzf "$1"     ;;
      *.bz2)       bunzip2 "$1"     ;;
      *.rar)       unrar x "$1"     ;;
      *.gz)        gunzip "$1"      ;;
      *.tar)       tar xf "$1"      ;;
      *.tbz2)      tar xjf "$1"     ;;
      *.tgz)       tar xzf "$1"     ;;
      *.zip)       unzip "$1"       ;;
      *.Z)         uncompress "$1"  ;;
      *.7z)        7z x "$1"        ;;
      *)           echo "'$1' cannot be extracted via extract()" ;;
    esac
  else
    echo "'$1' is not a valid file"
  fi
}

# fzf-based file finder (Omarchy style)
# Use 'ff' to fuzzy find files with preview
if command -v fzf &> /dev/null; then
  ff() {
    if command -v bat &> /dev/null; then
      fzf --preview 'bat --color=always {}' --preview-window=right:60%
    else
      fzf --preview 'head -100 {}' --preview-window=right:60%
    fi
  }
fi

# Quick server (Python)
serve() {
  local port="${1:-8000}"
  python3 -m http.server "$port"
}

# Git commit with message
# Unset alias if it exists (from OMZ git plugin) before defining function
unalias gcm 2>/dev/null || true
function gcm() {
  git commit -m "$1"
}

# Git add and commit
gac() {
  git add . && git commit -m "$1"
}

# Git push current branch
unalias gpu 2>/dev/null || true
gpu() {
  git push -u origin "$(git branch --show-current)"
}

# Lazy load nvm
load_nvm() {
  export NVM_DIR="$HOME/.nvm"
  [[ -s "$NVM_DIR/nvm.sh" ]] && \. "$NVM_DIR/nvm.sh"
  [[ -s "$NVM_DIR/bash_completion" ]] && \. "$NVM_DIR/bash_completion"
}

# Lazy load pyenv
load_pyenv() {
  export PYENV_ROOT="$HOME/.pyenv"
  if [[ -d "$PYENV_ROOT" ]]; then
    # Add pyenv to PATH if not already there
    if [[ ":$PATH:" != *":$PYENV_ROOT/bin:"* ]]; then
      export PATH="$PYENV_ROOT/bin:$PATH"
    fi
    if command -v pyenv &> /dev/null; then
      eval "$(pyenv init -)"
      # Also initialize pyenv-virtualenv if available
      if command -v pyenv-virtualenv-init &> /dev/null; then
        eval "$(pyenv virtualenv-init -)"
      fi
    fi
  fi
}

# Wrapper for 1password CLI to only allow login when direnv and .envrc are present
# This prevents constant password prompts when 1password is called globally
if command -v op &> /dev/null; then
  op() {
    local cmd="$1"
    # Check if this is a login/signin command
    if [[ "$cmd" == "signin" ]] || [[ "$cmd" == "login" ]]; then
      # Only allow login if we're in a directory with a .envrc file
      # and direnv is available
      if command -v direnv &> /dev/null; then
        local current_dir="$PWD"
        local found_envrc=false
        
        # Walk up the directory tree to find .envrc
        while [[ -n "$current_dir" ]] && [[ "$current_dir" != "/" ]]; do
          if [[ -f "$current_dir/.envrc" ]]; then
            found_envrc=true
            break
          fi
          # Stop at home directory to avoid checking parent directories
          if [[ "$current_dir" == "$HOME" ]]; then
            break
          fi
          current_dir="$(dirname "$current_dir")"
        done
        
        if [[ "$found_envrc" == "false" ]]; then
          echo "1password login is only allowed when a .envrc file is present in the current directory or a parent directory"
          return 1
        fi
      else
        echo "1password login requires direnv to be installed"
        return 1
      fi
    fi
    
    # For all other op commands, or if conditions are met, run the actual op command
    command op "$@"
  }
fi

# This fixes issues with fcitx5/ibus interfering with sudo password input
#sudo() {
#  # Temporarily disable input method environment variables for password prompt
#  if command -v fcitx5-remote >/dev/null 2>&1; then
#    # Switch to English input before sudo
#    fcitx5-remote -c 2>/dev/null || true
#  fi
#
#  # Run sudo with input method disabled for the password prompt
#  env GTK_IM_MODULE="" QT_IM_MODULE="" XMODIFIERS="" command sudo "$@"
#}

