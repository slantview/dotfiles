# Profile configuration with lazy loading for heavy tools

# Boxen (if exists)
[[ -f /opt/boxen/env.sh ]] && source /opt/boxen/env.sh

# GVM (Go Version Manager) - lazy load
load_gvm() {
  [[ -s "$HOME/.gvm/scripts/gvm" ]] && source "$HOME/.gvm/scripts/gvm"
}

# Conda - lazy load function
load_conda() {
  if [[ -f "$HOME/miniconda/etc/profile.d/conda.sh" ]]; then
    . "$HOME/miniconda/etc/profile.d/conda.sh"
  elif [[ -f "$HOME/anaconda3/etc/profile.d/conda.sh" ]]; then
    . "$HOME/anaconda3/etc/profile.d/conda.sh"
  elif [[ -f "/anaconda3/etc/profile.d/conda.sh" ]]; then
    . "/anaconda3/etc/profile.d/conda.sh"
  fi
}

# Cargo (Rust) - load if exists
[[ -f "$HOME/.cargo/env" ]] && source "$HOME/.cargo/env"

# NVM (Node Version Manager) - lazy load function
export NVM_DIR="$HOME/.nvm"
load_nvm() {
  [[ -s "$NVM_DIR/nvm.sh" ]] && \. "$NVM_DIR/nvm.sh"
  [[ -s "$NVM_DIR/bash_completion" ]] && \. "$NVM_DIR/bash_completion"
}

# Auto-load conda and nvm only if they're likely to be needed
# Uncomment the lines below if you want them to load automatically:
# load_conda
# load_nvm
