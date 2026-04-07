autoload -Uz compinit
compinit
zstyle ':completion:*' menu select
zstyle ':completion::complete:*' gain-privileges 1

export EDITOR=nvim
export VISUAL=nvim

alias ll='ls -lah'
alias lll='ls -lah | less'
alias grep='grep --color=auto'
# alias m="micro"
# alias hx="helix"
alias v="nvim"
alias qwerty="setxkbmap us -variant colemak"

ed() {
	command ed -p $'\n\e[1;32m'"$1"$'\e[0m'"> "
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
export PATH="$PATH:$HOME/.local/bin"
export PATH="$PATH:$HOME/.dotnet/tools"
