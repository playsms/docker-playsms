docker-playsms
==============

Item            | Info
--------------- | ---------------
Project update  | 250417
Project version | 3.2
playSMS version | [1.4.x](https://github.com/playsms/playsms)

This project is playSMS docker image project.

playSMS is a Free and Open Source SMS Gateway Software. Not A Free SMS Service.

Visit [playSMS](https://playsms.org) website for more information.


## Install & Usage

First, create `.env` by copying from `.env.example`:

```
cp .env.example .env
```

Edit `.env` file:

```
vi .env
```

Example `.env` content:
```
PLAYSMS_VERSION="1.4.x"

PLAYSMS_DB_NAME="playsms"
PLAYSMS_DB_USER="playsms"
PLAYSMS_DB_PASS="my_own_strong_password"
PLAYSMS_DB_HOST="mariadb"
PLAYSMS_DB_PORT=3306

DOCKER_IMAGE_PLAYSMS="playsms/playsms:1.4.x"
DOCKER_IMAGE_NGINX="nginx:stable-alpine"
DOCKER_IMAGE_MARIADB="mariadb:lts"

WEBSERVER_SERVER_NAME="localhost"
WEBSERVER_HTTP_PORT=80
WEBSERVER_HTTPS_PORT=443
```

Change playSMS DB password at least, and save it. The DB host should be `mariadb` unless you've changed it in [compose.yaml](https://github.com/playsms/docker-playsms/blob/master/compose.yaml).

Next, to install and then use it run this:

```
docker compose up
```

Run it and leave it:
```
docker compose up -d
```


## Build

If you need to build your own image edit the image name in `.env`

For example, set `DOCKER_IMAGE_PLAYSMS="yourrepo/yourimage:anytag"` in `.env`, and then build it:

```
docker compose build
```


## Maintainer

Anton Raharja <araharja@protonmail.com>

View contributors [here](https://github.com/playsms/docker-playsms/graphs/contributors)

