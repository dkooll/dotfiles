# path and environment settings
export GOENV_ROOT="$HOME/.goenv"
export PATH="$GOENV_ROOT/bin:$PATH"
eval "$(goenv init -)"
export PATH="$GOENV_ROOT/shims:$PATH"
export PATH="$HOME/.cargo/bin:$PATH"
export ZSH="$HOME/.oh-my-zsh"
export PATH="/opt/homebrew/bin:$PATH"
export HOMEBREW_NO_EMOJI=1
export GREP_OPTIONS="--color=never"
export TF_CLI_ARGS="-no-color"

export EZA_COLORS="\
di=38;5;109:\
fi=38;5;132:\
*.*=38;5;132:\
Makefile=38;5;132:\
README=38;5;132:\
Dockerfile=38;5;132:\
da=none:\
un=38;5;109:\
gu=38;5;109:\
uu=38;5;109:\
ur=38;5;187:\
uw=38;5;187:\
ux=38;5;187:\
gr=38;5;187:\
gw=38;5;187:\
gx=38;5;187:\
tr=38;5;187:\
tw=38;5;175:\
tx=38;5;187:\
sn=none:\
sb=none:\
hd=none:\
lp=none:\
cc=none:\
mi=none:\
pi=none:\
so=none:\
bd=none:\
cd=none:\
or=none:\
su=none:\
sf=none:\
ow=38;5;187:\
st=38;5;187\
"

TERM=xterm-256color

# history settings
HISTFILE="$HOME/.zsh_history"
HISTSIZE=1000
SAVEHIST=1000

# other alias definitions
alias tf='terraform'
alias cd="z"
alias nvim-dev='NVIM_APPNAME=nvim-dev nvim'

# zsh options
setopt INC_APPEND_HISTORY
setopt SHARE_HISTORY
setopt HIST_EXPIRE_DUPS_FIRST
setopt HIST_IGNORE_DUPS
setopt HIST_FIND_NO_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_VERIFY
setopt EXTENDED_HISTORY

# source scripts
source $ZSH/oh-my-zsh.sh
[[ -s "/Users/dkool/.gvm/scripts/gvm" ]] && source "/Users/dkool/.gvm/scripts/gvm"
eval "$(starship init zsh)"
eval "$(zoxide init zsh)"
eval "$(atuin init zsh)"

source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh

# https://github.com/junegunn/fzf-git.sh
source ~/fzf-git.sh/fzf-git.sh

# set up fzf key bindings and fuzzy completion
eval "$(fzf --zsh)"

# use fd instead of the default find command
export FZF_DEFAULT_COMMAND="fd --hidden --strip-cwd-prefix --exclude .git"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND" # search files with Ctrl-T
export FZF_ALT_C_COMMAND="fd --type d --hidden --strip-cwd-prefix --exclude .git" # cd into the selected directory with Alt-C

# use fd for listing path candidates
# the first argument to the function is the base path to start traversal
# see the source code (completion.{bash,zsh}) for the details
_fzf_compgen_path() {
  fd --hidden --exclude .git . "$1"
}

# use fd to generate the list for directory completion
_fzf_compgen_dir() {
  fd --type d --hidden --exclude .git . "$1"
}

# ssh agent and keys
if ! pgrep -u "$USER" ssh-agent > /dev/null; then
    eval "$(ssh-agent -s)"
fi

for key in ~/.ssh/id_rsa_*; do
    [[ -f $key ]] && ssh-add -q "$key" 2>/dev/null
done
