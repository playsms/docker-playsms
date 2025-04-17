docker-playsms
==============

Item            | Info
--------------- | ---------------
Project update  | 250417
Project version | 3.2
playSMS version | 1.4.x (master)

This project is playSMS docker image project.

playSMS is a Free and Open Source SMS Gateway Software. Not A Free SMS Service.

Visit [playSMS](http://playsms.org) website for more information.


## Install & Usage

First, create `.env` by copying from `.env.example`:

```
cp .env.example .env
```

Edit `.env` file, change playSMS DB password at least:

```
vi .env
```

Next, to install and then use it run this:

```
docker compose up
```


## Build

If you need to build your own image edit the image name in `.env`

For example, set `DOCKER_IMAGE_PLAYSMS="anyusername/anyimagename:anytag"` in `.env`, and then build it:

```
docker compose build
```


## Maintainer

- Anton Raharja <araharja@protonmail.com>
