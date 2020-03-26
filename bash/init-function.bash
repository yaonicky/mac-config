if [ "Linux" = "$(uname -s)" ]; then
	SYS_TYPE=L
elif [ "Darwin" = "$(uname -s)" ]; then
	SYS_TYPE=M
fi
### echo $SYS_TYPE

### 加入tab自動填充腳本
#SHARE_SHELL_PATH="$USER_HOME/Web/config/bash"
#source $SHARE_SHELL_PATH/autocomplete-git.bash
#source $SHARE_SHELL_PATH/autocomplete-symfony1.bash
#source $SHARE_SHELL_PATH/autocomplete-symfony2.bash
#source $SHARE_SHELL_PATH/autocomplete-lunchy.bash

alias ll='ls -al'
alias gs='git status'
alias php-v56='export PATH="/usr/local/opt/php@5.6/bin:$PATH"'
alias php-v70='export PATH="/usr/local/opt/php@7.0/bin:$PATH"'

function mcd() { cd $USER_HOME/Web/www/$1.$DOMAIN_SELF/$1; }
function mkcd() { mkdir -p "$@" && cd "$_"; }

function init-sf1() {
	if [[ -f "./symfony" ]]; then
		mkdir cache log web/uploads
		git submodule update --init
		cp config/databases.default.yml config/databases.yml
		cp config/symfonylib.default.php config/symfonylib.php
		./symfony plugin:publish-assets
		./symfony project:permission
		ln -sf $USER_HOME/Web/config/lib/symfony14/data/web/sf web/sf
	else
		echo "Please run in symfony project root path.";
	fi
}

function init-sf2() {
	if [[ -d "./vendor" ]]; then
		mkdir app/cache app/logs web/uploads
		if [ "M" = "$SYS_TYPE" ]; then
			chmod +a "_www allow delete,write,append,file_inherit,directory_inherit" app/cache app/logs web/uploads
			chmod +a "`whoami` allow delete,write,append,file_inherit,directory_inherit" app/cache app/logs web/uploads
			chmod 777 app/cache app/logs web/uploads
		else
			setfacl -R -m u:www:rwX -m u:`whoami`:rwX app/cache app/logs web/uploads
			setfacl -dR -m u:www:rwx -m u:`whoami`:rwx app/cache app/logs web/uploads
		fi
		app/console assets:install --symlink
		app/console assetic:dump
		
		app/console cache:clear --env=dev --no-optional-warmers
		app/console cache:clear --env=prod --no-optional-warmers
	else
		echo "Please run in symfony project root path after composer update.";
	fi
}

function init-sf3() {
	if [[ -d "./vendor" ]]; then
		mkdir var/cache var/logs var/sessions web/uploads
		if [ "M" = "$SYS_TYPE" ]; then
			chmod +a "_www allow delete,write,append,file_inherit,directory_inherit" var/cache var/logs var/sessions web/uploads
			chmod +a "`whoami` allow delete,write,append,file_inherit,directory_inherit" var/cache var/logs var/sessions web/uploads
			chmod 777 var/cache var/logs var/sessions web/uploads
		else
			setfacl -R -m u:www:rwX -m u:`whoami`:rwX var/cache var/logs web/uploads
			setfacl -dR -m u:www:rwx -m u:`whoami`:rwx var/cache var/logs web/uploads
		fi
		bin/console assets:install --symlink --relative
		bin/console assetic:dump
		
		bin/console cache:clear --env=dev --no-optional-warmers
		bin/console cache:clear --env=prod --no-optional-warmers
	else
		echo "Please run in symfony project root path after composer update.";
	fi
}

function web2chmod() {
  if [ "M" = "$SYS_TYPE" ]; then
    chmod +a "_www allow delete,write,append,file_inherit,directory_inherit" $@
    chmod +a "`whoami` allow delete,write,append,file_inherit,directory_inherit" $@
    chmod 777 $@
  else
    setfacl -R -m u:www:rwX -m u:`whoami`:rwX $@
    setfacl -dR -m u:www:rwx -m u:`whoami`:rwx $@
  fi
}