# prompt
autoload -U colors && colors
PS1="%{$fg[green]%}%m%{$reset_color%} %{$fg[blue]%}%c%{$reset_color%} %{$fg[red]%}$%{$reset_color%} "

# enable binding of ^s
stty -ixon

# enable binding of ^d
# setopt ignoreeof

# enable binding of ^q
# unsetopt flowcontrol

# ctrl d to interrupt
stty intr \^d

# ctrl q to eof
stty eof \^q

# enable vi mode
bindkey -v

# ctrl-a to go to beginning of line
# ctrl-e to go to end of line
bindkey '^a' beginning-of-line
bindkey '^e' end-of-line
bindkey -M vicmd '^a' beginning-of-line
bindkey -M vicmd '^e' end-of-line

# for some reason vi mode doesn't have '_' mapped to beginning of line
bindkey -M vicmd '_' beginning-of-line

# fix space issue with tab completion
ZLE_REMOVE_SUFFIX_CHARS=""

# ctrl f to clear screen
bindkey ^f clear-screen
bindkey -M vicmd ^f clear-screen

# ctrl s to list files
function list_widget() {
	echo
	pwd && exa --long --header --all --group-directories-first
	zle reset-prompt
}
zle -N list_widget
bindkey ^s list_widget
bindkey -M vicmd ^s list_widget

# ctrl g to show git status
function git_widget() {
	echo
	git status --short --branch
	zle reset-prompt
}
zle -N git_widget
bindkey ^g git_widget
bindkey -M vicmd ^g git_widget

# ctrl q to exit
function exit_widget() {
	exit
}
zle -N exit_widget
bindkey ^q exit_widget
bindkey -M vicmd ^q exit_widget

# history
HISTSIZE=10000
SAVEHIST=10000
HISTFILE=$HOME/.zhistory
setopt inc_append_history
setopt share_history
setopt extended_history

# misc
export EDITOR="vim"
export GTK_THEME=Adwaita:dark
export LESS="-R"
export LESSHISTFILE=/dev/null
export PAGER="bat"
export PATH="$HOME/.cargo/bin:$HOME/.deno/bin:$PATH"
export NODE_PATH=/usr/lib/node_modules:/usr/lib/node_modules/@tangramhq/eslint-plugin/node_modules
export PGUSER=postgres
export MOZ_ENABLE_WAYLAND=1

# conda
[ -f /opt/miniconda3/etc/profile.d/conda.sh ] && source /opt/miniconda3/etc/profile.d/conda.sh

# gpg
gpg-agent --daemon &> /dev/null
export GPG_TTY=$(tty)
export SSH_AUTH_SOCK=$HOME/.gnupg/S.gpg-agent.ssh

# fzf
export FZF_DEFAULT_OPTS="--reverse --exit-0 --select-1"
export FZF_DEFAULT_COMMAND="fd --type f --no-ignore"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_COMPLETION_TRIGGER=""
export FZF_COMPLETION_OPTS="--reverse"
_fzf_compgen_path() {
  fd --hidden --no-ignore --follow --exclude ".git" . "$1"
}
_fzf_compgen_dir() {
  fd --hidden --no-ignore --follow --exclude ".git" --type d . "$1"
}
source /usr/share/fzf/completion.zsh
source /usr/share/fzf/key-bindings.zsh

# aliases
alias dotfiles='git --git-dir $HOME/.dotfiles --work-tree $HOME'
alias rc='$EDITOR ~/.zshrc'
alias src='source ~/.zshrc'
alias d='trash'
alias e='vim'
alias f=''
alias g='rg'
alias h='http'
alias p='bat'
alias q='exit'
alias s='ls -a | xargs du -hs'
alias t='fd'
alias tree='exa -T'
alias u='cd ..'
alias loc='tokei -s code'
alias hex='hexyl'
alias irc='irssi'

alias ga='git add --all'
alias gbl='git branch -avv'
alias gcamend='git commit --amend --no-edit'
alias gcm='git add --all && git commit --message'
alias gd='git diff'
alias gds='git diff --staged'
alias gl='git log --all --graph --decorate --abbrev-commit --format=format:"%C(bold blue)%h%C(reset) - %C(bold white)%an%C(reset) %C(bold yellow)%d%C(reset)%n%C(bold cyan)%aD%C(reset) - %C(bold green)(%ar)%C(reset)%n%C(white)%s%C(reset)"'
alias gp='git pull --all --rebase'
alias gps='git push'
alias gpsa='git push --set-upstream --all'
alias gpsf='git push --force-with-lease --set-upstream'
alias gs='git status --short --branch'
alias gst='git stash --include-untracked'
alias gstc='git stash clear'
alias gstl='git stash list'
alias gstp='git stash pop --quiet'
alias gsts='git stash show -p'

alias sb='./scripts/build'
alias scl='./scripts/clean'
alias sch='./scripts/check'
alias sd='./scripts/dev'
alias sf='./scripts/fmt'
alias sl='./scripts/lint'
alias st='./scripts/test'

function weather() {
	curl -sSL http://wttr.in/$(echo "$@" | tr " " +)
}

function cheat() {
	curl -sSL http://cheat.sh/$(echo "$@" | tr " " +)
}
