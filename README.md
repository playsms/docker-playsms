docker-playsms
==============

Item            | Info
--------------- | ---------------
Project update  | 210203
Project version | 2.1
playSMS version | 1.4.3

This project is playSMS docker image project.

playSMS is a Free and Open Source SMS Gateway Software. Not A Free SMS Service.

Visit [playSMS](http://playsms.org) website for more information.


Install
-------

Run this for installation, just the first time:

```
docker run -d -p 2222:22 -p 80:80 antonraharja/playsms
```
	
Or, run this to mount MySQL database to local `/opt/mysql/lib` instead:

```
docker run -d -p 2222:22 -p 80:80 -v /opt/mysql/lib:/var/lib/mysql antonraharja/playsms
```

Or, run this if needed to also mount MySQL config to local `/opt/mysql/etc` too:

```
docker run -d -p 2222:22 -p 80:80 -v /opt/mysql/lib:/var/lib/mysql -v /opt/mysql/etc:/etc/mysql antonraharja/playsms
```


Check Installation
------------------

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
ssh -p 11022 root@localhost
```

And then change `root` password:

```
passwd root
```

Change the SSH password **immediately** to your own strong and secure password.

The default SSH password for user `root` is `changemeplease`


Usage and Operational
---------------------

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


Build
-----

To build the image `yourname/playsms`, execute the following command on the `docker-playsms` folder:

```
docker build -t yourname/playsms .
```

Push your new image to the docker hub:

```
docker push yourname/playsms
```


Maintainer
----------

- Anton Raharja <araharja@protonmail.com>


References
----------

- https://github.com/tutumcloud/tutum-docker-lamp
- https://github.com/tutumcloud/tutum-docker-wordpress
