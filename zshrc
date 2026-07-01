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

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# opencode
export PATH=/Users/steverude/.opencode/bin:$PATH

# Added by LM Studio CLI (lms)
export PATH="$PATH:/Users/steverude/.lmstudio/bin"
# End of LM Studio CLI section


# pnpm
export PNPM_HOME="/Users/steverude/Library/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end
export PATH="$PATH:$(go env GOPATH)/bin"
export GPG_TTY=$(tty)

# Added by codebase-memory-mcp install
export PATH="/Users/steverude/.local/bin:$PATH"
