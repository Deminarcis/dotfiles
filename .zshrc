#---------------------------------////
# Base16 Stuff
#-------------------------------////
# Base16 Shell
BASE16_SCHEME="monokai"
BASE16_SHELL="$HOME/.config/base16-shell/base16-$BASE16_SCHEME.dark.sh"
[[ -s $BASE16_SHELL ]] && . $BASE16_SHELL

#------------------------------////
# Aliases
#-----------------------------////

alias ls='ls -alh --color=auto'
alias info='uname -a'
alias version='lsb_release -a'
alias change-mouse-cursor='sudo update-alternatives --config x-cursor-theme'
alias cp='gcp'
alias df-all='df -Th --total'
alias external-ip='curl icanhazip.com'
alias broken-symlink='find . -type l -! -exec test -e {} \; -print'
alias boot-snappy='kvm -m 2048 -redir :8090::80 -redir :8022::22 -redir :4200::4200 ~/snappy.img'
alias set-res='export DISPLAY=:1 && xrandr --output DVI-I-1 --mode 1920x1080'
#------------------------------////
# Set up the prompt
#-----------------------------////
#prompt modules here
autoload -U colors && colors
autoload -U promptinit
autoload -Uz compinit
compinit

function precmd() # Uses: setting user/root PROMPT1 variable and rehashing commands list
{

export "RPROMPT=%B%F{magenta}%~%f%b"
export PROMPT="
%{$fg[magenta]%}┌─[%{$fg[red]%}%n%{$fg[magenta]%}]-[%{$fg[blue]%}%m%{$fg[magenta]%}]  %{$fg[yellow]%}%T
%{$fg[magenta]%}└── "

PS2='::>'

}

#Alternate Prompt

#export PROMPT="
#%{$fg[magenta]%}┌────[%{$fg[red]%}%T%{$fg[magenta]%}]-[%{$fg[red]%}%n%{$fg[blue]%} @%{$fg[yellow]%}%m%{$fg[magenta]%}] [%{$fg[blue]%} %~ %{$fg[magenta]%}]
#%{$fg[magenta]%}└──%{$fg[white]%} "
#PS2='>'

#------------------------------////
# Zsh autoload stuffs
#-----------------------------////

setopt histignorealldups
setopt CORRECT
setopt MULTIOS
setopt RM_STAR_WAIT
setopt GLOBDOTS
setopt NOCLOBBER
# Use emacs keybindings even if our EDITOR is set to vi
bindkey -e

# Keep 1000 lines of history within the shell and save it to ~/.zsh_history:
HISTSIZE=1000
SAVEHIST=1000
HISTFILE=~/.zsh_history
# Use modern completion system
autoload -Uz compinit
compinit

zstyle ':completion:*' auto-description 'specify: %d'
zstyle ':completion:*' completer _expand _complete _correct _approximate
zstyle ':completion:*' format 'Completing %d'
zstyle ':completion:*' group-name ''g
zstyle ':completion:*' menu select=2
eval "$(dircolors -b)"
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
zstyle ':completion:*' matcher-list '' 'm:{a-z}={A-Z}' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=* l:|=*'
zstyle ':completion:*' menu select=long
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
zstyle ':completion:*' use-compctl false
zstyle ':completion:*' verbose true

zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'
zstyle ':completion:*:kill:*' command 'ps -u $USER -o pid,%cpu,tty,cputime,cmd'


#------------------------------////
# Terminal Stuff
#-----------------------------////
clear

#load Screenfetch
#screenfetch

#load Fetch script
neofetch

#Screen for persistent SSH
#screen

#Tmux instead of screen
#tmux
#------------------------------////
# TTY Options
#-----------------------------////


#------------------------------////
# Exports
#-----------------------------////
export PATH=/home/jacob/swift-2.2-SNAPSHOT-2015-12-01-b-ubuntu15.10/usr/bin:"${PATH}"
export EDITOR="atom"
export WINEPREFIX="/home/jacob/.win32"
export WINEDEBUG=-all

#------------------------------////
#VTE Stuff (It has to go at the end)
#-----------------------------////
#. /etc/profile.d/vte-2.91.sh
