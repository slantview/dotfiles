# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh
ZSH_THEME="robbyrussell"

DISABLE_AUTO_UPDATE="true"
export UPDATE_ZSH_DAYS=14

plugins=(git golang brew docker vim-interaction git-aliases send)

source $ZSH/oh-my-zsh.sh

export EDITOR="vim"

export GOROOT="/usr/local/go"
export GOPATH="$HOME"
export ANDROID_HOME=$HOME/Library/Android/sdk
export PYTHONPATH=/usr/local/opt/python

export PATH="$HOME/miniconda/bin:/usr/local/opt/python/libexec/bin:$HOME/kotlin/bin:$HOME/bin:/opt/boxen/homebrew/bin:/Applications/Vagrant/bin:$GOPATH/bin:$GOROOT/bin:$HOME/.s3cmd:/usr/local/heroku/bin:$PATH"
export PATH="/Applications/Vagrant/bin:$GOPATH/bin:$GOROOT/bin:$HOME/.s3cmd:/usr/local/heroku/bin:$PATH"
export PATH=$PATH:$ANDROID_HOME/emulator
export PATH=$PATH:$ANDROID_HOME/tools
export PATH=$PATH:$ANDROID_HOME/tools/bin
export PATH=$PATH:$ANDROID_HOME/platform-tools
export PATH="/usr/local/opt/node@12/bin:$PATH"
export PATH="/usr/local/opt/postgresql@12/bin:$PATH"

# COMPLETION SETTINGS
# add custom completion scripts
fpath=(~/.zsh/completion $fpath)

# compsys initialization
autoload -U compinit
compinit
#
# show completion menu when number of options is at least 2
zstyle ':completion:*' menu select=2

source "$HOME/google-cloud-sdk/path.zsh.inc"
source "$HOME/google-cloud-sdk/completion.zsh.inc"
source $HOME/.zshrc_local

alias code="/Applications/Visual\ Studio\ Code.app/Contents/Resources/app/bin/code"
alias ug='uuidgen | tr "[:upper:]" "[:lower:]"'
