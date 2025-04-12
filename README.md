docker-playsms
==============

Item            | Info
--------------- | ---------------
Project update  | 250412
Project version | 3.0
playSMS version | 1.4.8-2504120000

This project is playSMS docker image project.

playSMS is a Free and Open Source SMS Gateway Software. Not A Free SMS Service.

Visit [playSMS](http://playsms.org) website for more information.


## Install/Usage

First, create `.env` by copying from `.env.example`:

```
cp .env.example .env
```

To install and then use it, run this:

```
docker compose up
```

If you need to build your own image edit the image name in `.env`

For example, set `PLAYSMS_DOCKER_IMAGE="anyusername/anyimagename:anytag"` in `.env`, and then build it:

```
docker compose build
```


## Maintainer

- Anton Raharja <araharja@protonmail.com>
