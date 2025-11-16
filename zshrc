# Main zsh configuration
# Source the modular zsh configuration

# Determine if we're in the dotfiles repo or installed location
DOTFILES_DIR=""
if [[ -f "${0:a:h}/zsh/zshrc" ]]; then
  # Running from dotfiles repo
  DOTFILES_DIR="${0:a:h}"
  source "${0:a:h}/zsh/zshrc"
elif [[ -f "$HOME/.zsh/zshrc" ]]; then
  # Running from installed location
  source "$HOME/.zsh/zshrc"
elif [[ -f "$HOME/.config/zsh/zshrc" ]]; then
  # Alternative config location
  source "$HOME/.config/zsh/zshrc"
fi

# Source local zshrc if it exists
[[ -f "$HOME/.zshrc_local" ]] && source "$HOME/.zshrc_local"
