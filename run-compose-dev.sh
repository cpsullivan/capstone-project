#!/bin/bash

# These environment variables are consumed by the docker-compose file.
# We can supply explicit defaults that are checked in with source code 
# since they are only used for local development.
export SECRET_KEY=abc123
export DEBUG=True
export POSTGRES_DB=wines
export POSTGRES_USER=postgres
export POSTGRES_PASSWORD=postgres
export AWS_ACCESS_KEY_ID=$1
export AWS_SECRET_ACCESS_KEY=$2

docker-compose -f docker-compose.dev.yml up -d --build

# make sure the postgres container is ready, then run migrations
sleep 10 
docker exec docker-compose-app-api-1  python /src/manage.py makemigrations 
docker exec docker-compose-app-api-1  python /src/manage.py migrate