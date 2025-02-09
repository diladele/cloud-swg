#!/bin/bash

# stop all compose services to prevent external writes
docker compose down

# start only the database service in detached mode
docker compose up db -d

# run the backup of the database and save the output directly into data folder
docker compose exec db /usr/bin/pg_dump -U postgres | gzip >data/database.sql.gz
