#!/bin/bash

STRING="cd /var/www/app; sudo chmod -R 777 storage;"

ask() {
    while true; do
        if [ "${2:-}" = "Y" ]; then
            prompt="Y/n"
            default=Y
        elif [ "${2:-}" = "N" ]; then
            prompt="y/N"
            default=N
        else
            prompt="y/n"
            default=
        fi

        read -p "$1 [$prompt] " REPLY
 
        if [ -z "$REPLY" ]; then
            REPLY=$default
        fi
 
        case "$REPLY" in
            Y*|y*) return 0 ;;
            N*|n*) return 1 ;;
        esac 
    done
}

setPull() {
	STRING="$STRING git pull; git checkout develop; composer dump-autoload;"
}

setMigrationReset() {
	STRING="$STRING php artisan migrate:reset;"
}

setMigration() {
	STRING="$STRING php artisan migrate --seed;"
}

if ask "Refresh database?" y; then
	setMigrationReset
	setPull
	setMigration
else
	if ask "Migrate database?" y; then
		setPull
		setMigration
	else
		setPull
	fi
fi

if ask "composer update?" y; then
    STRING="$STRING composer update; git checkout composer.lock;"
fi

STRING="$STRING php artisan route:scan; php artisan route:cache; gulp;"

ssh myServer "$STRING";

echo '***************************** String *****************************';
echo $STRING;
echo '***************************** String *****************************';