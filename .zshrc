# Path and environment
export PATH="/opt/homebrew/bin:$HOME/.cargo/bin:$PATH"
export GOROOT="$(brew --prefix golang)/libexec"
export GOPATH="$HOME/go"
export PATH="$GOPATH/bin:$PATH"
export ZSH="$HOME/.oh-my-zsh"
export HOMEBREW_NO_EMOJI=1
export GREP_OPTIONS="--color=never"
export TF_CLI_ARGS="-no-color"
export EZA_COLORS="di=38;5;109:fi=38;5;132:*.*=38;5;132:Makefile=38;5;132:README=38;5;132:Dockerfile=38;5;132:da=none:un=38;5;109:gu=38;5;109:uu=38;5;109:ur=38;5;187:uw=38;5;187:ux=38;5;187:gr=38;5;187:gw=38;5;187:gx=38;5;187:tr=38;5;187:tw=38;5;175:tx=38;5;187:sn=none:sb=none:hd=none:lp=none:cc=none:mi=none:pi=none:so=none:bd=none:cd=none:or=none:su=none:sf=none:ow=38;5;187:st=38;5;187"
export TERM=xterm-256color

# History
export HISTFILE="$HOME/.zsh_history"
export HISTSIZE=1000
export SAVEHIST=1000

# Alias definitions
alias tf='terraform'
alias cd='z'
alias t='tmux'
alias nvim-dev='NVIM_APPNAME=nvim-dev nvim'

# ZSH options
setopt INC_APPEND_HISTORY SHARE_HISTORY HIST_EXPIRE_DUPS_FIRST HIST_IGNORE_DUPS HIST_FIND_NO_DUPS HIST_IGNORE_SPACE HIST_VERIFY EXTENDED_HISTORY

# Source scripts and initialize tools
source $ZSH/oh-my-zsh.sh
[[ -s "/Users/dkool/.gvm/scripts/gvm" ]] && source "/Users/dkool/.gvm/scripts/gvm"
eval "$(starship init zsh)"
eval "$(zoxide init zsh)"
eval "$(atuin init zsh)"
source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh
source ~/fzf-git.sh/fzf-git.sh

# FZF setup
eval "$(fzf --zsh)"
export FZF_DEFAULT_COMMAND="fd --hidden --strip-cwd-prefix --exclude .git"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND="fd --type d --hidden --strip-cwd-prefix --exclude .git"

# FZF completion functions
_fzf_compgen_path() {
  fd --hidden --exclude .git . "$1"
}
_fzf_compgen_dir() {
  fd --type d --hidden --exclude .git . "$1"
}

# SSH agent and keys
if ! pgrep -u "$USER" ssh-agent > /dev/null; then
    eval "$(ssh-agent -s)"
fi
for key in ~/.ssh/id_rsa_*; do
    [[ -f $key ]] && ssh-add -q "$key" 2>/dev/null
done
