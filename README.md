# MLR_Legacy_DB
Liquibase/Docker Configuration for the Legacy Monitoring Location Database

## Database Setup
This project will provision a postgreSQL database in a Docker container, load some test data and expose it to the host system on port 5432. You will need both Docker (Machine) and Docker Compose to build and run the database container.

Also, create a .env file in you project's root directory to specify passwords for the database. It should contain:
```
LIQUIBASE_HOME=/opt/liquibase
POSTGRES_JDBC_VERSION=postgres-42.2.4.jar
POSTGRES_PASSWORD=changeMe
MLR_LEGACY_PASSWORD=changeMe
MLR_LEGACY_DATA_PASSWORD=changeMe
MLR_LEGACY_USER_PASSWORD=changeMe
MLR_RDS_ADDRESS=127.0.0.1
MLR_LIQUIBASE_VERSION=1.5
PGPORT=5432
```

## Database Port Change

You may wish to have the Docker container run Postgres on a port that differs from
the standard Postgres port 5432. If you wish to change the port on which the database
runs on, you can update the `PGPORT` environment variable in your docker-compose
.env file. For example, if you wish for the Postgres database to run on port 5435,
change the `PGPORT` value from 5432 to 5435 and re-launch the container.

If you wish for the database service to be reachable from your host, you will also
want to change the port mapping in your docker-compose file. For example, if you
have the `PGPORT` value set to 5435, change the ports mapping from the standard
"5432:5432" to "5435:5435".

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
