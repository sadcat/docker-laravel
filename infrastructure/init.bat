@echo off

md docker\php\bash\psysh
copy nul docker\php\bash\.bash_history
docker-compose up -d --build
docker-compose exec app composer install
docker-compose exec app cp .env.example .env
docker-compose exec app php artisan key:generate
docker-compose exec app php artisan storage:link
docker-compose exec app php artisan migrate:fresh --seed
