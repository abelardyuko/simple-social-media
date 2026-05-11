#!/bin/sh
set -e

mkdir -p bootstrap/cache \
         storage/framework/cache \
         storage/framework/sessions \
         storage/framework/views

chown -R www-data:www-data bootstrap storage || true
chmod -R ug+rwx bootstrap storage || true

npm install --legacy-peer-deps --no-audit --progress=false
npm run dev
composer install --optimize-autoloader
cp .env.example .env || true
php artisan key:generate

sed -i 's/DB_HOST=127.0.0.1/DB_HOST=172.17.0.2/g' .env
sed -i 's/DB_PASSWORD=/DB_PASSWORD=password/g' .env

php artisan migrate --force
php artisan db:seed --force
$ chmod +x install.sh

12. Buat virtual host apache untuk simpel-social-media

$ nano sosmed.conf
<VirtualHost *:8000>
        ServerAdmin webmaster@localhost
        DocumentRoot /var/www/sosmed
        ErrorLog ${APACHE_LOG_DIR}/error.log
        CustomLog ${APACHE_LOG_DIR}/access.log combined
</VirtualHost>
