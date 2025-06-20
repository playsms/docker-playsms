docker-playsms
==============

Item            | Info
--------------- | ---------------
Project update  | 250425
Project version | 3.6
playSMS version | [1.4.x](https://github.com/playsms/playsms)

This project is playSMS docker image project.

playSMS is a Free and Open Source SMS Gateway Software. Not A Free SMS Service.

Visit [playSMS](https://playsms.org) website for more information.


# Install

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
PLAYSMS_DB_PASS="playsms"
PLAYSMS_DB_HOST="mariadb"
PLAYSMS_DB_PORT=3306

WEB_ADMIN_PASSWORD="changemeplease"

PLAYSMS_CONTAINER_TIMEZONE="Asia/Jakarta"

DOCKER_IMAGE_PLAYSMS="playsms/playsms:1.4.x"
DOCKER_IMAGE_NGINX="nginx:stable-alpine"
DOCKER_IMAGE_MARIADB="mariadb:lts"

WEBSERVER_SERVER_NAME="localhost"
WEBSERVER_HTTP_PORT=80
WEBSERVER_HTTPS_PORT=443

GID=1000
UID=1000
```

Change playSMS DB password and web admin password at least, and save it.
The DB host should be `mariadb` unless you've changed it in [compose.yaml](https://github.com/playsms/docker-playsms/blob/master/compose.yaml).

Next, to install and then use it run this:
```
docker compose up
```

Note that web admin password is `changemeplease` if you dont change it on `.env` file.


# Usage

Run it and leave it:
```
docker compose up -d
```

Check `compose.yaml` for volumes. Nginx configuration can be found in `nginx/` locally but MariaDB and playSMS files are mounted to named volumes.

Suppose you build your own image and update playSMS, then you only need to remove/empty `playsms-web` volume.
The installer will know that you have existing data already and will not re-insert with fresh install.

But please backup first before trying.


# Build

If you need to build your own image edit the image name in `.env`

For example, set `DOCKER_IMAGE_PLAYSMS="yourrepo/yourimage:anytag"` in `.env`, and then build it:
```
docker compose build
```


## Maintainer

Anton Raharja <araharja@protonmail.com>

View contributors [here](https://github.com/playsms/docker-playsms/graphs/contributors)

