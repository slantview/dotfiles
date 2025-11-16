# PATH management with deduplication

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

# Function to append path only if it exists and isn't already in PATH
append_to_path() {
  local dir="$1"
  if [[ -d "$dir" ]] && [[ ":$PATH:" != *":$dir:"* ]]; then
    export PATH="$PATH:$dir"
  fi
}

# Core paths (always first)
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
  if [[ -n "$HOMEBREW_PREFIX" ]]; then
    prepend_to_path "$HOMEBREW_PREFIX/bin"
    prepend_to_path "$HOMEBREW_PREFIX/sbin"
    prepend_to_path "$HOMEBREW_PREFIX/opt/python/libexec/bin"
    prepend_to_path "$HOMEBREW_PREFIX/opt/node@12/bin"
    prepend_to_path "$HOMEBREW_PREFIX/opt/postgresql@12/bin"
  fi
  
  prepend_to_path "/opt/boxen/homebrew/bin"
  prepend_to_path "/Applications/Vagrant/bin"
  
elif [[ "$IS_LINUX" == "true" ]] || [[ "$IS_WSL" == "true" ]]; then
  # Linux/WSL paths
  prepend_to_path "/usr/local/bin"
  prepend_to_path "/usr/local/sbin"
fi

# Common development tools
prepend_to_path "$HOME/kotlin/bin"
prepend_to_path "$HOME/.s3cmd"
prepend_to_path "$HOME/.cargo/bin"
prepend_to_path "/usr/local/heroku/bin"

# pyenv setup - lazy loaded via load_pyenv() function in functions.zsh
# Set PYENV_ROOT for reference, but don't initialize until needed
export PYENV_ROOT="$HOME/.pyenv"

# Cargo environment (if installed)
if [[ -f "$HOME/.cargo/env" ]]; then
  source "$HOME/.cargo/env"
fi

# Android SDK paths
if [[ -n "$ANDROID_HOME" ]] && [[ -d "$ANDROID_HOME" ]]; then
  append_to_path "$ANDROID_HOME/emulator"
  append_to_path "$ANDROID_HOME/tools"
  append_to_path "$ANDROID_HOME/tools/bin"
  append_to_path "$ANDROID_HOME/platform-tools"
fi

# Google Cloud SDK
if [[ -f "$HOME/google-cloud-sdk/path.zsh.inc" ]]; then
  source "$HOME/google-cloud-sdk/path.zsh.inc"
fi

# Clean up functions (no longer needed after PATH is set)
unset -f add_to_path
unset -f prepend_to_path
unset -f append_to_path

