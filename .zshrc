# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
setopt appendhistory extendedglob nomatch notify
unsetopt autocd
bindkey -v
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/gthomas/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall

#colors and prompt
autoload -U colors && colors
PS1="%{$fg[red]%}%n%{$reset_color%}@%{$fg[blue]%}%m %{$fg[yellow]%}%~ %{$reset_color%}%% "

#aliases
alias l='ls -lA --color=auto'
alias go-windows-386='CGO_ENABLED=1 GOOS=windows GOARCH=386 go "$@"'
#alias go-linux-386='CGO_ENABLED=1 GOOS=linux GOARCH=386 go "$@"'


# PATH
export CHROMIUM_USER_FLAGS="--memory-model=low --purge-memory-button --enable-internal-flash"
if [ -d $HOME/bin ]; then
    export PATH=$HOME/bin:$PATH
fi

export GOPATH=~/projects/go
if [ -x /usr/local/go/bin/go ]; then
    export GOROOT=/usr/local/go
    export PATH=$PATH:$GOPATH/bin:$GOROOT/bin
fi

ulimit -v 2048000 -m 2048000 -d 2048000

ORACLE_HOME=/u01/app/oracle/product/11.2.0/xe
if [ -d $ORACLE_HOME ]; then
    export ORACLE_HOME
    export ORACLE_SID=XE
    export ORACLE_BASE=/u01/app/oracle
    export PATH=$ORACLE_HOME/bin:$PATH
fi

for nm in sakura lxterminal xfce4-terminal urxvtcd; do
    if which $nm >/dev/null; then
        export TERMINAL=$nm
        break
    fi
done


function makelink {
    DN=$1
    if readlink ~/$DN >/dev/null; then
        mkdir -p $(readlink ~/$DN)
    else
        D=/tmp/${USER}
        if [ -d $D/$DN ]; then
            echo "Deleting ~/$DN"
            rm -rf ~/$DN && ln -fs $D/$DN ~/$DN
        else
            echo "Deleting $D/$DN"
            rm -rf $D/$DN
            echo "Moving ~/$DN to $D/$DN"
            mkdir -p $D && mv ~/$DN $D/ && ln -fs $D/$DN ~/$DN
        fi
    fi
}

makelink .cache
makelink Downloads

[ -x ~/bin/uno-ssh ] && . ~/bin/uno-ssh
# tmux
if which tmux 2>&1 >/dev/null; then
    if [ -z "$TMUX" ] && [ "$TERM" = urxvt-unicode ]; then
        exec tmux
    fi
fi
