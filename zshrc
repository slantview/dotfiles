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
export GOROOT="/usr/local/go"
export GOPATH="/Users/srude/Documents/workspace/go"
export PATH="/Applications/Vagrant/bin:$GOPATH/bin:$GOROOT/bin:$HOME/.s3cmd:/usr/local/heroku/bin:$PATH"

export DOCKER_HOST="tcp://192.168.59.103:2375"

source /opt/boxen/env.sh
source /Users/srude/.travis/travis.sh
source $HOME/google-cloud-sdk/path.zsh.inc
source $HOME/.zshrc_local

alias drush="$HOME/.drush/drush"
alias atom='/Applications/Atom.app/Contents/Resources/app/atom.sh'
