#
# History and Completeion
#
autoload -U compinit
compinit -u
autoload -Uz colors ; colors
autoload -Uz history-search-end

zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
HISTFILE=${HOME}/.zsh-history
HISTSIZE=10000000
SAVEHIST=100000

compdef mosh=ssh

export PATH=/usr/local/Cellar/ruby/2.0.0-p195/bin:$PATH
export JAVA_TOOL_OPTIONS=-Dfile.encoding=UTF-8


if [[ ! -z `compaudit` ]]; then
  compaudit | xargs chmod g-w
fi

bindkey -v
bindkey -a 'q' push-line
bindkey -a 'h' run-help
bindkey "" history-incremental-search-backward
bindkey "" history-incremental-search-forward
bindkey "[3~" delete-char

zstyle ':completion:*' use-cache true
zstyle ':completion:*' accept-exact '*(N)'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' verbose yes
zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
zstyle ':completion:*' completer _complete _match _approximate
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %P Lines: %m
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*:*:-subscript-:*' tag-order indexes parameters
zstyle ':completion:*:approximate:*' max-errors 1
zstyle ':completion:*:corrections' format $'%{\e[0;31m%}%d (errors: %e)%}'
zstyle ':completion:*:default' menu select auto
zstyle ':completion:*:descriptions' format '%B%d%b'
zstyle ':completion:*:expand:*' tag-order all-expansions
zstyle ':completion:*:functions' ignored-patterns '(_*|pre(cmd|exec))'
zstyle ':completion:*:history-words' stop yes
zstyle ':completion:*:history-words' remove-all-dups yes
zstyle ':completion:*:history-words' list false
zstyle ':completion:*:history-words' menu yes
zstyle ':completion:*:manuals' separate-sections true
zstyle ':completion:*:match:*' original only
zstyle ':completion:*:messages' format '%d'
zstyle ':completion:*:warnings' format 'No matches for: %d'
zstyle ':completion:*:-tilde-:*' group-order 'named-directories' 'path-directories' 'users' 'expand'
zstyle ':completion::*:(-command-|export):*' fake-parameters ${${${_comps[(I)-value-*]#*,}%%,*}:#-*-}
zstyle ':completion:::::' completer _complete _approximate

autoload -U zmv
alias zmv='noglob zmv'
autoload -U zfinit
zmodload zsh/complist
zmodload zsh/zftp



#
# Configuration
#
limit coredumpsize 102400
setopt prompt_subst
setopt nobeep
setopt long_list_jobs
setopt list_types
setopt auto_resume
setopt auto_list
setopt hist_ignore_dups
setopt autopushd
setopt pushd_ignore_dups
setopt extended_glob
setopt auto_menu
setopt extended_history
setopt equals
setopt magic_equal_subst
setopt hist_verify
setopt numeric_glob_sort
setopt print_eight_bit
setopt share_history
setopt auto_cd
setopt auto_param_keys
setopt auto_param_slash
setopt correct
setopt noautoremoveslash
setopt complete_aliases
setopt glob_complete


#
# Prompt
#
case ${UID} in
  0)
    zstyle ':completion:*' command-path $HOME/bin /usr/local/sbin /usr/local/bin /usr/X11/bin /usr/sbin /usr/bin /sbin /bin
    PROMPT="%{${fg[magenta]}%}%n@%m%{${reset_color}%} %{${fg[blue]}%}#%{${reset_color}%} "
    ;;
  *)
    zstyle ':completion:*' command-path $HOME/bin /usr/local/bin /usr/X11/bin /usr/bin /bin $PATH
    zstyle ':completion:*:sudo:*' command-path $HOME/bin /usr/local/sbin /usr/local/bin /usr/X11/bin /usr/sbin /usr/bin /sbin /bin
    case ${OSTYPE} in
      darwin*)
        PROMPT="%{${fg[cyan]}%}%n@%m%{${reset_color}%} %{${fg[blue]}%}$%{${reset_color}%} "
        ;;
      linux*)
        case ${HOST} in
          p*)
            PROMPT="%{${fg[green]}%}%n@%m%{${reset_color}%} %{${fg[blue]}%}$%{${reset_color}%} "
            ;;
          *)
            PROMPT="%{${fg[yellow]}%}%n@%m%{${reset_color}%} %{${fg[blue]}%}$%{${reset_color}%} "
            ;;
        esac
        ;;
    esac
    ;;
esac
PROMPT2="%B%{${fg[magenta]}%}%_#%{${reset_color}%}%b "
SPROMPT="%B%{${fg[magenta]}%}%r is correct? [n,y,a,e] :%{${reset_color}%}%b "

case "${TERM}" in
  kterm*|xterm)
    precmd() {
      echo -ne "\033]0;${USER}@${HOST%%.*}:${PWD}\007"
    }
    ;;
esac


#
# Aliases and Functions
#
alias ls="ls -vF --color"
alias dir="dir --color"
alias cp="cp -iv"
alias mv="mv -iv"
alias rm="rm -v"
alias c="cd"
alias v="vi"
alias l="ls"
alias q="exit"
alias la="ls -A"
alias ll="ls -l"
alias lla="ls -lA"
alias ss="sudo su"
alias ce="crontab -e"
alias cv="convmv -f utf-8 --nfd -t utf-8 --nfc -r ."
alias twitter="tw -st"
alias twit="yes|tw $1 2>&1 > /dev/null"
function chkey() {
  if [ -z $1 ]; then
    tmux set-option prefix C-a
    tmux bind C-a last-window
    tmux bind a last-window
  else
    tmux set-option prefix C-$1
    tmux bind C-$1 last-window
    tmux bind $1 last-window
  fi
}
[[ ! -s `which tailf` ]] && alias tailf="tail -f"
[[ -s `which htop` ]] && alias top="htop"
[[ -s `which hub` ]] && alias git="hub"
function socks() {
  PORT=$1
  HOST=$2
  ssh -N -f -c 3des -D localhost:$PORT $HOST
}
function search() {
  DIR=$1
  KEY=$2
  [[ ! -d $1 && ! -f $1 && $1 != '.' ]] && KEY=$DIR && DIR='.'
  grep --color -n -r -i "$KEY" "$DIR"
}
function count() {
  echo $(( `ls -l | wc -l`-1 )) `du -sh`
}
function psx() {
  ps aux | grep $1 | grep -v grep
}
preexec () {
  #echo ">> which ${1%% *} 2 > /dev/null"
  #echo ">> `which ${1%% *} 2 > /dev/null`"
  cmd=${1%% *}
  if [ -z "`whence ${cmd}`" ]; then
    if [ $cmd = 'yabai' ]; then
      arg=${1##* }
      echo "$arg is YABAI"
      kill -s INT $PPID
    fi
  fi
}

function do_enter() {
    if [ -n "$BUFFER" ]; then
        zle accept-line
        return 0
    fi
    echo
    ls
    # ↓おすすめ
    # ls_abbrev
    if [ "$(git rev-parse --is-inside-work-tree 2> /dev/null)" = 'true' ]; then
        echo
        echo -e "\e[0;33m--- git status ---\e[0m"
        git status -sb
    fi
    zle reset-prompt
    return 0
}
zle -N do_enter
bindkey '^m' do_enter

#
# Git Prompt
#
__git_files() { _files }
autoload -Uz add-zsh-hook
autoload -Uz vcs_info
zstyle ':vcs_info:*' enable git svn hg bzr
zstyle ':vcs_info:*' formats '(%s)-[%b]'
zstyle ':vcs_info:*' actionformats '(%s)-[%b|%a]'
zstyle ':vcs_info:(svn|bzr):*' branchformat '%b:r%r'
zstyle ':vcs_info:bzr:*' use-simple true
autoload -Uz is-at-least
if is-at-least 4.3.10; then
  zstyle ':vcs_info:git:*' check-for-changes true
  zstyle ':vcs_info:git:*' stagedstr "^"
  zstyle ':vcs_info:git:*' unstagedstr "*"
  zstyle ':vcs_info:git:*' formats '[%s](%b) %c%u'
  zstyle ':vcs_info:git:*' actionformats '[%s](%b|%a) %c%u'
fi
function _update_vcs_info_msg() {
  psvar=()
  LANG=en_US.UTF-8 vcs_info
  [[ -n "$vcs_info_msg_0_" ]] && psvar[1]="$vcs_info_msg_0_"
}
add-zsh-hook precmd _update_vcs_info_msg
RPROMPT="%1(v|%F{green}%1v%f|)"
RPROMPT="$RPROMPT %{${fg[blue]}%}[%/]%{${reset_color}%}"

if [ ! -z "`which tmux`" ]; then
  if [ $SHLVL = 1 ]; then
    if [ $(( `ps aux | grep tmux | grep $USER | grep -v grep | wc -l` )) != 0 ]; then
      echo -n 'Attach tmux session? [Y/n]'
      read YN
      [[ $YN = '' ]] && YN=y
      [[ $YN = y ]] && tmux attach
    fi
  fi
fi

if [[ "$TMUX" != "" ]] then
  alias pbcopy="ssh 127.0.0.1 pbcopy"
  alias pbpaste="ssh 127.0.0.1 pbpaste"
fi

# Tmux branch
PS1="$PS1"'$([ -n "$TMUX" ] && tmux setenv TMUXPWD_$(tmux display -p "#D" | tr -d %) "$PWD")'

