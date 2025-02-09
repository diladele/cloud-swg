#!/bin/bash

# stop all compose services to prevent external writes
docker compose down

# start only app service in the detached mode
docker compose up app -d

# run the tar command in the app container
docker compose exec app tar -czvf /repo.tar.gz /opt/cloud-swg-repo

# copy from the container to host
docker compose cp app:/repo.tar.gz data/
