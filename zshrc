ZSH=$HOME/.oh-my-zsh
EDITOR=vim
LANG=en_US.UTF-8
HISTSIZE=999999999
SAVEHIST=$HISTSIZE
setopt EXTENDED_HISTORY       # Write the history file in the ":start:elapsed;command" format.
setopt INC_APPEND_HISTORY     # Write to the history file immediately, not when the shell exits.
setopt SHARE_HISTORY          # Share history between all sessions.
setopt HIST_EXPIRE_DUPS_FIRST # Expire duplicate entries first when trimming history.
setopt HIST_IGNORE_DUPS       # Don't record an entry that was just recorded again.
setopt HIST_IGNORE_ALL_DUPS   # Delete old recorded entry if new entry is a duplicate.
setopt HIST_FIND_NO_DUPS      # Do not display a line previously found.
setopt HIST_IGNORE_SPACE      # Don't record an entry starting with a space.
setopt HIST_SAVE_NO_DUPS      # Don't write duplicate entries in the history file.
setopt HIST_REDUCE_BLANKS     # Remove superfluous blanks before recording entry.
setopt HIST_VERIFY
setopt AUTO_CD
setopt AUTO_NAME_DIRS         # This will use named dirs when possible
setopt GLOB_COMPLETE          # If we have a glob this will expand it
setopt PUSHD_MINUS

alias vim=nvim
alias dkcl="docker container prune -f;docker image prune -f"

plugins=(
  git
  bundler
  brew
  gem
  docker
  aws
  tmux
  terraform
)

# Go
export GOPATH=$HOME/Developer/Go
export GOROOT=/usr/local/opt/go/libexec
export PATH=$PATH:$GOPATH/bin
export PATH=$PATH:$GOROOT/bin

# for Homebrew installed rbenv
if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi

# Source
source $ZSH/oh-my-zsh.sh
source $HOME/.zsh/scripts/venv-auto.sh
source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
