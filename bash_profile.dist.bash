USER_HOME="/Users/nicky"
DOMAIN_SELF="dev"
source $USER_HOME/Web/config/bash/init-function.bash

### Setting for the new UTF-8 terminal support in Lion
export LC_CTYPE=en_US.UTF-8
export LC_ALL=en_US.UTF-8

### Setting Folder Color
export CLICOLOR=1
export LSCOLORS=ExFxBxDxCxegedabagacad

### Change Prompt
# http://www.marinamele.com/2014/05/customize-colors-of-your-terminal-in-mac-os-x.html
# ------------------------------------------------------------
export PS1='[\[\e[0;35m\]\h\[\e[m\]: \[\e[0;36m\]\w\[\e[m\] ] \n\[\e[1;32m\]\u \$\[\e[m\] \[\e[m\]\[\e[0;37m\]'

### Set Paths
# ------------------------------------------------------------
export PATH="$USER_HOME/Web/config/bin:$PATH"
# ------------------------------------------------------------
