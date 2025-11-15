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
gcm() {
  git commit -m "$1"
}

# Git add and commit
gac() {
  git add . && git commit -m "$1"
}

# Git push current branch
gpu() {
  git push -u origin "$(git branch --show-current)"
}

# Lazy load nvm
load_nvm() {
  export NVM_DIR="$HOME/.nvm"
  [[ -s "$NVM_DIR/nvm.sh" ]] && \. "$NVM_DIR/nvm.sh"
  [[ -s "$NVM_DIR/bash_completion" ]] && \. "$NVM_DIR/bash_completion"
}

# Lazy load conda
load_conda() {
  if [[ -f "$HOME/miniconda/etc/profile.d/conda.sh" ]]; then
    . "$HOME/miniconda/etc/profile.d/conda.sh"
  elif [[ -f "$HOME/anaconda3/etc/profile.d/conda.sh" ]]; then
    . "$HOME/anaconda3/etc/profile.d/conda.sh"
  fi
}

# Sudo wrapper that disables input method for password prompts
# This fixes issues with fcitx5/ibus interfering with sudo password input
sudo() {
  # Temporarily disable input method environment variables for password prompt
  if command -v fcitx5-remote >/dev/null 2>&1; then
    # Switch to English input before sudo
    fcitx5-remote -c 2>/dev/null || true
  fi
  
  # Run sudo with input method disabled for the password prompt
  env GTK_IM_MODULE="" QT_IM_MODULE="" XMODIFIERS="" command sudo "$@"
}

