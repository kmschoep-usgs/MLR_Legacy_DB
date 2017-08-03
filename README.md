docker exec -i -t b8a0cc3d717a /bin/bash


docker run --name some-postgis -e POSTGRES_PASSWORD=mysecretpassword -d mdillon/postgis:9.6-alpine