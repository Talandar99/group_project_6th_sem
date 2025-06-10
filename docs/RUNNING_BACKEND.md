# running php backend in project
## prerequisites
- Docker

## General Idea
You have to first run database standalone, and populate it with data, than you can run backend container

## Windows
```sh
# TODO 
# add step by step guide similar to linux one bellow

.\scripts\setupdocker_backend.bat # populate database with data before this command
```

## Linux
```sh
# run database
cd database/
docker compose up -d
cd ..
# run pgsql_execute_database_querry to populate database with data
sudo ./scripts/pgsql_execute_database_querry.sh
# compose down database
cd database
docker compose down
# run backend with database
sudo ./scripts/setupdocker_backend.sh
```
