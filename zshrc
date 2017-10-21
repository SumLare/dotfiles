ZSH=$HOME/.oh-my-zsh
ZSH_THEME="robbyrussell"
setopt AUTO_CD
# This will use named dirs when possible
setopt AUTO_NAME_DIRS
# If we have a glob this will expand it
setopt GLOB_COMPLETE
setopt PUSHD_MINUS

plugins=(git bundler brew gem)

source $ZSH/oh-my-zsh.sh

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

# zprezto
source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"

# Go
export GOPATH=$HOME/Developer/Go
export GOROOT=/usr/local/opt/go/libexec
export PATH=$PATH:$GOPATH/bin
export PATH=$PATH:$GOROOT/bin

# for Homebrew installed rbenv
if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi
