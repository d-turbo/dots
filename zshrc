export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_STATE_HOME="$HOME/.local/state"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_BIN_HOME="$HOME/.local/bin"

export PATH="$PATH:$XDG_BIN_HOME"

autoload -Uz compinit
compinit -d "$XDG_CACHE_HOME/zsh/.zcompdump"
zstyle ':completion:*' menu select
zstyle ':completion::complete:*' gain-privileges true

export EDITOR=nvim
export VISUAL=nvim

alias ll='ls -lah'
alias lll='ls -lah | less'
alias less='less -Nsc'
alias grep='grep --color=auto'
# alias m="micro"
# alias hx="helix"
alias v="nvim"
alias qwerty="setxkbmap us -variant colemak"

ed() {
	local file="$1"
	shift
	command ed -p $'\n\e[1;32m'"$file"$'\e[0m> ' "$file" "$@"
}

webdump() {
	curl -s "$1" | command webdump -8 -a -i -r -l -b "$1" | less -R
}

set -o vi
autoload -z edit-command-line
zle -N edit-command-line
bindkey "^Z" edit-command-line
bindkey "^[[P" delete-char

setopt HIST_IGNORE_ALL_DUPS
setopt HIST_SAVE_NO_DUPS
setopt INC_APPEND_HISTORY
setopt SHARE_HISTORY
setopt AUTO_CD
setopt CORRECT

# prompts
PROMPT="$ "
# RPROMPT="%T"
# ZLE_RPROMPT_INDENT=0

source /usr/share/zsh/plugins/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh

export XINITRC="$HOME/.config/X11/xinitrc"
export QT_QPA_PLATFORMTHEME="qt5ct"

# source /usr/share/nvm/init-nvm.sh
# export PATH="$PATH:$HOME/.dotnet/tools"
