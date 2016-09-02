## Dockerized Mapit **WIP**

### How to run this

You actually don't need this repository to try it out. The docker image built from this is
automatically available from the [Docker Hub](https://hub.docker.com/).

First, you'll need to install [Docker](https://docs.docker.com/) if you don't already have it.

Then,
```
docker build -t mapit:global .
docker run --link overpass_container_id:overpass -d mapit:global
```

Execute `curl http://${docker inspect --format '{{.NetworkSettings.IPAddress}}' $CONTAINER_ID}/point/4326/-16.5450,28.4114`

```
sudo docker exec -i -t {CONTAINER_ID} /bin/bash
```

And install:

http://mapit.poplus.org/docs/self-hosted/import/global/
