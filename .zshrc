# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH
#
# Updating some path
path+=("$HOME/.local/bin")
path+=("$HOME/.local/share/gem/ruby/3.0.0/bin")
path+=("$HOME/.local/share/gem/ruby/3.2.0/bin")
path+=("$HOME/.local/share/gem/ruby/3.3.0/bin")
path+=("$HOME/bin")
path+=('/root/.local/share/gem/ruby/3.0.0/bin')
paht+=('/opt/homebrew/opt/gnu-sed/libexec/gnubin')
path+=("$HOME/.cargo/bin")

export PATH

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="robbyrussell"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment one of the following lines to change the auto-update behavior
zstyle ':omz:update' mode disabled  # disable automatic updates
# zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
# zstyle ':omz:update' frequency 13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate $HOME/.zshrc"
# alias ohmyzsh="mate $HOME/.oh-my-zsh"

# Existence helpers
function function-exists {
  which $argv[1] > /dev/null 2> /dev/null
  return $?
}

function dir-exists {
  test -d $argv[1]
  return $status
}

function file-exists {
  test -e $argv[1]
  return $status
}

# Tmux helper
function tm {
  [ -z $TMUX ] && tmux a || tmux
}

# Alias helper
function checked-alias {
  INPUT=$1

  DEST=$(echo $INPUT | awk -F'=' '{ print $1 }')
  SOURCE=$(echo $INPUT | awk -F'=' '{ print $2 }')

  function-exists $SOURCE && alias $DEST=$SOURCE
}

# Lock & Goto
GOTO_FILE=$HOME/.config/.goto

function set-goto {
  local DESTINATION="$1"

  echo $DESTINATION > $GOTO_FILE

  echo "Set goto to $DESTINATION"
}

function home {
  set-goto $PWD
}

function goto {
  local DESTINATION=$(cat $GOTO_FILE)

  cd $DESTINATION
}

# Load private configs
PRIVATE_CONFIG=$HOME/.zsh.private
file-exists $PRIVATE_CONFIG && source $PRIVATE_CONFIG

# Use more modern equivalent to classic tools
checked-alias find=fd
checked-alias ls=exa
checked-alias vim=nvim

# Clipboard shortcuts
checked-alias c=pbcopy
checked-alias v=pbpaste

# FZF
# [ -f $HOME/.fzf.zsh ] && source $HOME/.fzf.zsh
source <(fzf --zsh)

# FZF File Search with Rg
function-exists rg && export FZF_DEFAULT_COMMAND='rg --files --hidden --smart-case --no-ignore --glob "!.git/*"'

# Sway helper
function is-swayfx {
  sway --version | grep swayfx > /dev/null 2> /dev/null
  return $?
}

# open
checked-alias open=xdg-open
