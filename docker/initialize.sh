#!/bin/sh
echo "php.ini.example copying php.ini"
cp -n laravel/php.ini.example laravel/php.ini
echo "[msg]docker container making"
docker-compose up -d
echo "[msg].env file copy"
docker-compose exec laravel cp .env.example .env
docker-compose exec laravel cp .env.testing.example .env.testing
docker-compose exec laravel composer install
echo "[msg]production key generate";
docker-compose exec laravel php artisan key:generate
echo "[msg]testing key generate";
docker-compose exec laravel php artisan key:generate --env=testing
echo "[msg]production database migrate";
docker-compose exec laravel php artisan migrate
echo "[msg]testing database migrate";
docker-compose exec laravel php artisan migrate --env=testing
echo "------------INITIALIZE COMPLETE------------";
docker-compose exec laravel php --version
docker-compose exec laravel php artisan --version
echo "-------------------------------------------";
docker-compose ps
