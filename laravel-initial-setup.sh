#!/bin/bash
composer install;
npm install;
bower install;

mkdir resources/views/master/gulp;
echo '<!-- bower:css --><!-- endbower --><!-- inject:css --><!-- endinject -->' >> resources/views/master/gulp/css.blade.php;
echo '<!-- bower:js --><!-- endbower --><!-- inject:js --><!-- endinject -->' >> resources/views/master/gulp/js.blade.php;
gulp --production;

sudo chmod -R 777 bootstrap/cache/;
sudo chmod -R 777 storage/;
sudo chown -R www-data:www-data storage/;

mkdir uploads;
mkdir uploads/certificates;
sudo chmod -R 777 uploads/certificates;
sudo chown -R www-data:www-data uploads/certificates;

php artisan route:scan;
php artisan optimize;