## Dockerized Mapit **WIP**

### How to run this

You actually don't need this repository to try it out. The docker image built from this is
automatically available from the [Docker Hub](https://hub.docker.com/).

First, you'll need to install [Docker](https://docs.docker.com/) if you don't already have it.

Then,
```
docker build -t mapit:global .
docker run --link overpass-api:0.7.55 -d mapit:global
```

Execute `curl http://{IP}/point/4326/-16.5450,28.4114`
