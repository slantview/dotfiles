export EDITOR="vim"

export PATH="$HOME/bin:/Applications/Vagrant/bin:$GOPATH/bin:$GOROOT/bin:$HOME/.s3cmd:/usr/local/heroku/bin:$PATH"

export DOCKER_HOST=tcp://192.168.99.100:2376
export DOCKER_MACHINE_NAME=default
export DOCKER_TLS_VERIFY=1
export DOCKER_CERT_PATH=/Users/srude/.docker/machine/machines/default

export GOROOT="/c/Go"
export GOPATH="$HOME"
export PATH="/c/Program Files/nodejs:$GOPATH/bin:$GOROOT/bin:$HOME/.s3cmd:/usr/local/heroku/bin:$PATH"

source $HOME/.bashrc_local

# The next line updates PATH for the Google Cloud SDK.
#source '/Users/srude/google-cloud-sdk/path.zsh.inc'

# The next line enables shell command completion for gcloud.
#source '/Users/srude/google-cloud-sdk/completion.zsh.inc'
