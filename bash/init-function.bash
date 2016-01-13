if [ "Linux" = "$(uname -s)" ]; then
	SYS_TYPE=L
elif [ "Darwin" = "$(uname -s)" ]; then
	SYS_TYPE=M
fi
SHARE_SHELL_PATH="$USER_HOME/Web/bash"
### echo $SYS_TYPE

### 加入tab自動填充腳本
source $SHARE_SHELL_PATH/autocomplete-git.bash
source $SHARE_SHELL_PATH/autocomplete-symfony1.bash
source $SHARE_SHELL_PATH/autocomplete-symfony2.bash

function mcd(){
	cd $USER_HOME/Web/www/$1.$SELF_DOMAIN/$1
}

function init-sf1(){
	if [[ -f "./symfony" ]]; then
		mkdir cache log web/uploads
		git submodule update --init
		cp config/databases.default.yml config/databases.yml
		cp config/symfonylib.default.php config/symfonylib.php
		./symfony plugin:publish-assets
		./symfony project:permission
		ln -s $USER_HOME/Web/lib/symfony14/data/web/sf web/sf
	else
		echo "Please run in symfony project root path.";
	fi
}

function init-sf2(){
	if [[ -d "./vendor" ]]; then
		mkdir app/cache app/logs web/uploads
		if [ "M" = "$SYS_TYPE" ]; then
			chmod +a "_www allow delete,write,append,file_inherit,directory_inherit" app/cache app/logs web/uploads
			chmod +a "`whoami` allow delete,write,append,file_inherit,directory_inherit" app/cache app/logs web/uploads
			chmod 777 app/cache app/logs web/uploads
		else
			setfacl -R -m u:apache:rwX -m u:`whoami`:rwX app/cache app/logs web/uploads
			setfacl -dR -m u:apache:rwx -m u:`whoami`:rwx app/cache app/logs web/uploads
		fi
		app/console assets:install --symlink
		app/console assetic:dump
		
		app/console cache:clear --env=dev --no-optional-warmers
		app/console cache:clear --env=prod --no-optional-warmers
	else
		echo "Please run in symfony project root path after composer update.";
	fi
}

function sf2chmod(){
  if [ "M" = "$SYS_TYPE" ]; then
    chmod +a "_www allow delete,write,append,file_inherit,directory_inherit" $@
    chmod +a "`whoami` allow delete,write,append,file_inherit,directory_inherit" $@
    chmod 777 $@
  else
    setfacl -R -m u:apache:rwX -m u:`whoami`:rwX $@
    setfacl -dR -m u:apache:rwx -m u:`whoami`:rwx $@
  fi
}