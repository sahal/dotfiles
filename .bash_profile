# Bash prompt
export PS1="\u@macsauce[\w]$ \[$(tput sgr0)\]"

# vimode in bash, can't live without it
set -o vi

# import more bash fun
source $HOME/.bash_aliases
# for those aliases that i can't share...
#+redirected output so I don't get an error msg
source $HOME/.bash_alias_noshare > /dev/null 2>&1 || true
source $HOME/.bash_functions
source $HOME/.bash_completion

# HISTORY
export HISTSIZE=5000
export HISTFILESIZE=10000
export HISTCONTROL=ignoreboth
export HISTTIMEFORMAT="%d/%m/%y %T "

# ansible
export ANSIBLE_VAULT_PASSWORD_FILE="$HOME/.vault_pass.txt"
export ANSIBLE_CONFIG="$HOME/.ansible/ansible.cfg"
export ANSIBLE_NOCOWS=1

export AWS_SDK_LOAD_CONFIG=true
export VISUAL="vim"
export EDITOR="$VISUAL"
export GPG_AGENT_INFO=""

PATH="$HOME/bin:$PATH"
PATH="/usr/local/bin:$PATH"
PATH="$HOME/.local/bin:$PATH"
PATH="/usr/local/opt/coreutils/libexec/gnubin:$PATH"
PATH="/usr/local/opt/gnu-sed/libexec/gnubin:$PATH"
PATH="/usr/local/opt/gnu-tar/libexec/gnubin:$PATH"
PATH="$(brew --prefix coreutils)/libexec/gnubin:$PATH"
PATH="/usr/local/sbin:$PATH"
PATH="$(pyenv root)/shims:$PATH"
#PATH="/usr/local/Cellar/python/2.7.14/bin:$PATH"
PATH="~/.rbenv/shims:$PATH"
MANPATH="/usr/local/opt/coreutils/libexec/gnuman:$MANPATH"
MANPATH="/usr/local/opt/gnu-sed/libexec/gnuman:$MANPATH"
MANPATH="/usr/local/opt/gnu-tar/libexec/gnuman:$MANPATH"
export PATH
export MANPATH

PATH="/Users/sahalansari/perl5/bin${PATH:+:${PATH}}"; export PATH;
PERL5LIB="/Users/sahalansari/perl5/lib/perl5${PERL5LIB:+:${PERL5LIB}}"; export PERL5LIB;
PERL_LOCAL_LIB_ROOT="/Users/sahalansari/perl5${PERL_LOCAL_LIB_ROOT:+:${PERL_LOCAL_LIB_ROOT}}"; export PERL_LOCAL_LIB_ROOT;
PERL_MB_OPT="--install_base \"/Users/sahalansari/perl5\""; export PERL_MB_OPT;
PERL_MM_OPT="INSTALL_BASE=/Users/sahalansari/perl5"; export PERL_MM_OPT;
