docker-playsms
==============

Item            | Info
--------------- | ---------------
Project update  | 230922
Project version | 2.3
playSMS version | 1.4.6

This project is playSMS docker image project.

playSMS is a Free and Open Source SMS Gateway Software. Not A Free SMS Service.

Visit [playSMS](http://playsms.org) website for more information.


## Install

Run this for installation, just the first time:

```
docker run -d -p 2222:22 -p 80:80 playsms/playsms:1.4.6
```
	
Or, run this to bind MySQL database with local `/opt/mysql/lib` instead:

```
docker run -d -p 2222:22 -p 80:80 -v /opt/mysql/lib:/var/lib/mysql playsms/playsms:1.4.6
```

Get `<CONTAINER_ID>` of your image:

```
docker ps -l
```

Follow logs:

```
docker logs -f <CONTAINER_ID>
```

Once `sshd` runs, change the default SSH password, enter container:

```
ssh -p 2222 root@localhost
```

And then change `root` password:

```
passwd root
```

Change the SSH password **immediately** to your own strong and secure password.

The default SSH password for user `root` is `changemeplease`


## Usage

Start your container:

```
docker start <CONTAINER_ID>
```

Stop your container:

```
docker stop <CONTAINER_ID>
```

Running command inside the container:

```
docker exec <CONTAINER_ID> <COMMAND>
```

Example of running command `playsmsd check` on `CONTAINER_ID` `dce344`:

```
docker exec dce344 playsmsd check
```


## Build

To build the image `yourname/playsms`, execute the following command on the `docker-playsms` folder:

```
docker build -t yourname/playsms .
```

Push your new image to the docker hub:

```
docker push yourname/playsms
```


## Maintainer

- Anton Raharja <araharja@protonmail.com>


## References

- https://github.com/tutumcloud/tutum-docker-lamp
- https://github.com/tutumcloud/tutum-docker-wordpress
