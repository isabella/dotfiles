# prompt
autoload -U colors && colors
PS1="%{$fg[green]%}%m%{$reset_color%} %{$fg[blue]%}%c%{$reset_color%} %{$fg[red]%}$%{$reset_color%} "

# enable vi mode
bindkey -v

# use the system clipboard
function zsh-system-clipboard-vicmd-vi-yank() {
	zle vi-yank
	printf '%s' "$CUTBUFFER" | wl-copy
}
zle -N zsh-system-clipboard-vicmd-vi-yank
bindkey -M vicmd 'y' zsh-system-clipboard-vicmd-vi-put
function zsh-system-clipboard-vicmd-vi-put() {
}
zle -N zsh-system-clipboard-vicmd-vi-yank
function zsh-system-clipboard-vicmd-vi-put-after() {
	zsh-system-clipboard-vicmd-vi-put after
}
zle -N zsh-system-clipboard-vicmd-vi-put-after
function zsh-system-clipboard-vicmd-vi-put-before() {
	zsh-system-clipboard-vicmd-vi-put before
}
zle -N zsh-system-clipboard-vicmd-vi-put-before
bindkey -M vicmd 'P' zsh-system-clipboard-vicmd-vi-put-before
bindkey -M vicmd 'p' zsh-system-clipboard-vicmd-vi-put-after

# set cursor based on keymap
function zle-line-init {
	print -n -- "\e[5 q"
}
function zle-keymap-select {
	case $KEYMAP in
		main) print -n -- "\e[5 q";;
		vicmd) print -n -- "\e[0 q";;
	esac
}
function zle-line-finish {
	print -n -- "\e[0 q"
}
zle -N zle-line-init
zle -N zle-line-finish
zle -N zle-keymap-select

# set highlight colors
zle_highlight=(region:bg=#333333;paste:bg=none)

# enable binding of ^s
stty -ixon

# ctrl d to interrupt
stty intr \^d

# ctrl q to quit
stty quit \^q

# ctrl-a to go to the beginning of the line.
# ctrl-e to go to the end of the line.
bindkey '^a' beginning-of-line
bindkey '^e' end-of-line
bindkey -M vicmd '^a' beginning-of-line
bindkey -M vicmd '^e' end-of-line

# H and L to move to the beginning and end of a line.
bindkey -M vicmd 'H' beginning-of-line
bindkey -M vicmd 'L' end-of-line

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
HISTFILE=~/.zhistory
setopt inc_append_history
setopt share_history
setopt extended_history

# misc
export BROWSER="firefox"
export EDITOR="nvim"
export GTK_THEME=Adwaita:dark
export LESS="-R"
export LESSHISTFILE=/dev/null
export OPENER="xdg-open"
export PASSWORD_STORE_DIR="~/.pass"
export PATH="~/.local/bin:~/.cargo/bin:~/.deno/bin:~/.bin:$PATH"
export PGUSER=postgres

# conda
[ -f /opt/miniconda3/etc/profile.d/conda.sh ] && source /opt/miniconda3/etc/profile.d/conda.sh

# gpg
export GPG_TTY=$(tty)
export SSH_AUTH_SOCK=$(gpgconf --list-dirs agent-ssh-socket)

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

# less
[ -f ~/.config/.lesskey ] && lesskey

# lf
[ -f ~/.config/lf/icons ] && source ~/.config/lf/icons

# aliases
alias d='trash'
alias dotfiles='git --git-dir ~/.dotfiles --work-tree ~/'
alias e='nvim'
alias f='lf'
alias g='rg'
alias hs='caddy run --adapter caddyfile --config ~/.hs'
alias http='xh'
alias mail='aerc'
alias open='xdg-open'
alias p='bat'
alias pm='paru'
alias rc='$EDITOR ~/.zshrc'
alias src='source ~/.zshrc'
alias t='fd'
alias tree='exa -T'
alias u='cd ..'

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

# alias build='./scripts/build'
# alias clean='./scripts/clean'
# alias check='./scripts/check'
# alias deploy='./scripts/deploy'
# alias dev='./scripts/dev'
# alias fmt='./scripts/fmt'
# alias lint='./scripts/lint'
# alias test='./scripts/test'

function pmsave() {
	pm -Qe | awk '{print $1}' > ~/.packages
}

function screencapture() {
	wf-recorder -f screencapture_$(date +%s).mp4
}

function screenshot() {
	grim -g "$(slurp)" screenshot_$(date +%s).png
}

function screencolor() {
	grim -g "$(slurp -p)" -t ppm - | convert - -format "%[pixel:p{0,0}]" txt:-
}

function weather() {
	curl -sSL http://wttr.in/$(echo "$@" | tr " " +)
}

function cheat() {
	curl -sSL http://cheat.sh/$(echo "$@" | tr " " +)
}

function csv() {
	column -s, -t < $@ | less -S
}

function startw() {
	export XDG_CURRENT_DESKTOP=sway
	export XDG_SESSION_TYPE=wayland
	export MOZ_ENABLE_WAYLAND=1
	sway
}

