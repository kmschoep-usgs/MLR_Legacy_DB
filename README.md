# MLR_Legacy_DB
Liquibase/Docker Configuration for the Legacy Monitoring Location Database

## Database Setup
This project will provision a postgreSQL database in a Docker container and expose it to the host system on port 5435. You will need both Docker (Machine) and Docker Compose to build and run the database container.

Also, create a .env file in you project's root directory to specify passwords for the database. It should contain:
```
POSTGRES_PASSWORD=changeMe
MLR_LEGACY_PASSWORD=changeMe
MLR_LEGACY_DATA_PASSWORD=changeMe
MLR_LEGACY_USER_PASSWORD=changeMe
```

## Handy Commands

* __docker-compose up__ to create and start the containers
* __docker-compose ps__ to list the containers
* __docker-compose stop__ to stop the containers
* __docker-compose start__ to start the containers
* __docker network inspect nldidb_default__ to get the ip addresses of the running containers
* __docker-compose ps -q__ to get the Docker Compose container ids
* __docker ps -a__ to list all the Docker containers
* __docker rm <containerId>__ to remove a container
* __docker rmi <imageId>__ to remove an image
* __docker logs <containerID>__ to view the Docker Compose logs in a container
* __docker exec -i -t <containerID> /bin/bash__ to connect to a running container
