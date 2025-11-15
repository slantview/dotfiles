# OS detection and platform-specific configurations

# Detect OS
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

# Platform-specific settings
if [[ "$IS_MACOS" == "true" ]]; then
  # macOS specific
  export ANDROID_HOME="$HOME/Library/Android/sdk"
  export PYTHONPATH="/usr/local/opt/python"
  
  # Homebrew paths
  if [[ -d "/opt/homebrew" ]]; then
    # Apple Silicon
    export HOMEBREW_PREFIX="/opt/homebrew"
  elif [[ -d "/usr/local" ]]; then
    # Intel
    export HOMEBREW_PREFIX="/usr/local"
  fi
  
  # Visual Studio Code
  if [[ -d "/Applications/Visual Studio Code.app" ]]; then
    alias code="/Applications/Visual\ Studio\ Code.app/Contents/Resources/app/bin/code"
  fi
  
elif [[ "$IS_LINUX" == "true" ]] || [[ "$IS_WSL" == "true" ]]; then
  # Linux/WSL specific
  export ANDROID_HOME="$HOME/Android/Sdk"
  
  # Visual Studio Code (WSL)
  if [[ "$IS_WSL" == "true" ]] && command -v code.exe &> /dev/null; then
    alias code="code.exe"
  fi
fi

