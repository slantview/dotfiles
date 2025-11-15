# Bash configuration with cross-platform support

# Editor
export EDITOR="nvim"
export VISUAL="nvim"
alias vim="nvim"
alias vi="nvim"

# OS detection
if [[ "$OSTYPE" == "linux-gnu"* ]]; then
  export OS_TYPE="linux"
  export IS_LINUX=true
  export IS_MACOS=false
  export IS_WSL=false
  
  # Detect WSL
  if [[ -f /proc/version ]] && grep -q Microsoft /proc/version; then
    export IS_WSL=true
    export OS_TYPE="wsl"
  fi
elif [[ "$OSTYPE" == "darwin"* ]]; then
  export OS_TYPE="macos"
  export IS_LINUX=false
  export IS_MACOS=true
  export IS_WSL=false
elif [[ "$OSTYPE" == "msys" ]] || [[ "$OSTYPE" == "cygwin" ]]; then
  export OS_TYPE="windows"
  export IS_LINUX=false
  export IS_MACOS=false
  export IS_WSL=false
else
  export OS_TYPE="unknown"
  export IS_LINUX=false
  export IS_MACOS=false
  export IS_WSL=false
fi

# Function to add path only if it exists and isn't already in PATH
add_to_path() {
  local dir="$1"
  if [[ -d "$dir" ]] && [[ ":$PATH:" != *":$dir:"* ]]; then
    export PATH="$dir:$PATH"
  fi
}

# Function to prepend path only if it exists and isn't already in PATH
prepend_to_path() {
  local dir="$1"
  if [[ -d "$dir" ]] && [[ ":$PATH:" != *":$dir:"* ]]; then
    export PATH="$dir:$PATH"
  fi
}

# Core paths
prepend_to_path "$HOME/bin"

# Go paths
if [[ -n "$GOROOT" ]] && [[ -d "$GOROOT/bin" ]]; then
  prepend_to_path "$GOROOT/bin"
fi
if [[ -n "$GOPATH" ]] && [[ -d "$GOPATH/bin" ]]; then
  prepend_to_path "$GOPATH/bin"
fi

# Platform-specific paths
if [[ "$IS_MACOS" == "true" ]]; then
  # macOS paths
  if [[ -d "/opt/homebrew" ]]; then
    # Apple Silicon
    prepend_to_path "/opt/homebrew/bin"
    prepend_to_path "/opt/homebrew/sbin"
  elif [[ -d "/usr/local" ]]; then
    # Intel
    prepend_to_path "/usr/local/bin"
    prepend_to_path "/usr/local/sbin"
  fi
  prepend_to_path "/opt/boxen/homebrew/bin"
  prepend_to_path "/Applications/Vagrant/bin"
  
elif [[ "$IS_LINUX" == "true" ]] || [[ "$IS_WSL" == "true" ]]; then
  # Linux/WSL paths
  prepend_to_path "/usr/local/bin"
  prepend_to_path "/usr/local/sbin"
  
  # WSL specific
  if [[ "$IS_WSL" == "true" ]]; then
    # Visual Studio Code in WSL
    if command -v code.exe &> /dev/null; then
      alias code="code.exe"
    fi
  fi
  
elif [[ "$OS_TYPE" == "windows" ]]; then
  # Windows (Git Bash/Cygwin/MSYS)
  if [[ -d "/c/Go/bin" ]]; then
    prepend_to_path "/c/Go/bin"
  fi
  if [[ -d "/c/Program Files/nodejs" ]]; then
    prepend_to_path "/c/Program Files/nodejs"
  fi
fi

# Common development tools
prepend_to_path "$HOME/miniconda/bin"
prepend_to_path "$HOME/kotlin/bin"
prepend_to_path "$HOME/.s3cmd"
prepend_to_path "$HOME/.cargo/bin"
prepend_to_path "/usr/local/heroku/bin"

# Google Cloud SDK
if [[ -f "$HOME/google-cloud-sdk/path.bash.inc" ]]; then
  source "$HOME/google-cloud-sdk/path.bash.inc"
fi
if [[ -f "$HOME/google-cloud-sdk/completion.bash.inc" ]]; then
  source "$HOME/google-cloud-sdk/completion.bash.inc"
fi

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

# Clean up functions
unset -f add_to_path
unset -f prepend_to_path

# Source local overrides (if exists)
[[ -f "$HOME/.bashrc_local" ]] && source "$HOME/.bashrc_local"
