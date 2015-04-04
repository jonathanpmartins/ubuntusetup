#!/bin/bash

echo '********** Preparing Deploy to Develop Branch *********';

STRING="cd /var/www/app; sudo chmod -R 777 storage; sudo chown -R www-data:adm storage/;"

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

if ask "bower update?" y; then
    STRING="$STRING bower update;"
fi

if ask "gulp?" y; then
    STRING="$STRING gulp --production;"
fi

STRING="$STRING php artisan optimize; php artisan route:scan; php artisan route:cache;"

ssh myServer "$STRING";

echo '***************************** String *****************************';
echo $STRING;
echo '***************************** String *****************************';