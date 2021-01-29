# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="robbyrussell"

# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# Set to this to use case-sensitive completion
# CASE_SENSITIVE="true"

# Comment this out to disable bi-weekly auto-update checks
DISABLE_AUTO_UPDATE="true"

# Uncomment to change how often before auto-updates occur? (in days)
# export UPDATE_ZSH_DAYS=13

# Uncomment following line if you want to disable colors in ls
# DISABLE_LS_COLORS="true"

# Uncomment following line if you want to disable autosetting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment following line if you want to disable command autocorrection
# DISABLE_CORRECTION="true"

# Uncomment following line if you want red dots to be displayed while waiting for completion
# COMPLETION_WAITING_DOTS="true"

# Uncomment following line if you want to disable marking untracked files under
# VCS as dirty. This makes repository status check for large repositories much,
# much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(git golang brew docker vim-interaction)

source $ZSH/oh-my-zsh.sh

export EDITOR="vim"

export PATH="$HOME/miniconda/bin:/usr/local/opt/python/libexec/bin:$HOME/kotlin/bin:$HOME/bin:/opt/boxen/homebrew/bin:/Applications/Vagrant/bin:$GOPATH/bin:$GOROOT/bin:$HOME/.s3cmd:/usr/local/heroku/bin:$PATH"

#export DOCKER_HOST="tcp://192.168.59.103:2376"
#export DOCKER_CERT_PATH="$HOME/.boot2docker/certs/boot2docker-vm"
#export DOCKER_TLS_VERIFY=1
#
export GOROOT="/usr/local/go"
export GOPATH="$HOME"
export PATH="/Applications/Vagrant/bin:$GOPATH/bin:$GOROOT/bin:$HOME/.s3cmd:/usr/local/heroku/bin:$PATH"

alias atom='/Applications/Atom.app/Contents/Resources/app/atom.sh'
alias subl="/Applications/Sublime\ Text.app/Contents/SharedSupport/bin/subl"
alias code="/Applications/Visual\ Studio\ Code.app/Contents/Resources/app/bin/code"

# COMPLETION SETTINGS
# add custom completion scripts
fpath=(~/.zsh/completion $fpath)

# compsys initialization
autoload -U compinit
compinit
#
# show completion menu when number of options is at least 2
zstyle ':completion:*' menu select=2

source $HOME/.zshrc_local

# The next line updates PATH for the Google Cloud SDK.
source '/Users/srude/google-cloud-sdk/path.zsh.inc'

# The next line enables shell command completion for gcloud.
source '/Users/srude/google-cloud-sdk/completion.zsh.inc'

alias ug='uuidgen | tr "[:upper:]" "[:lower:]"'

export ANDROID_HOME=$HOME/Library/Android/sdk
export PATH=$PATH:$ANDROID_HOME/emulator
export PATH=$PATH:$ANDROID_HOME/tools
export PATH=$PATH:$ANDROID_HOME/tools/bin
export PATH=$PATH:$ANDROID_HOME/platform-tools
export PATH="/usr/local/opt/node@12/bin:$PATH"
export PYTHONPATH=/usr/local/opt/python
export PATH="/usr/local/opt/postgresql@12/bin:$PATH"
