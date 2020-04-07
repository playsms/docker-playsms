docker-playsms
==============

Item            | Info
--------------- | ---------------
Project update  | 200407
Project version | 2.0
playSMS version | 1.4.3

This project is playSMS docker image project.

playSMS is a Free and Open Source SMS Gateway Software. Not A Free SMS Service.

Visit [playSMS](http://playsms.org) website for more information.


Build
-----

To build the image `yourname/playsms`, execute the following command on the `docker-playsms` folder:

	docker build -t yourname/playsms .

Push your new image to the docker hub:

	docker push yourname/playsms


Install
-------

Pull/download the image from docker hub:

	docker pull antonraharja/playsms

Run this for installation, just the first time:

	docker run -d -p 11022:22 -p 11080:80 -p 11033:3306 antonraharja/playsms

Get `<CONTAINER_ID>` of your image:

	docker ps -l

Follow logs:

	docker logs -f <CONTAINER_ID>

Once `sshd` runs, change the default shell or SSH root password:

	ssh -p 11022 root@localhost
	passwd root

Change the password to your own secure password. The default shell or SSH root password is `changemeplease`


Usage
-----

Start your container:

	docker start <CONTAINER_ID>

Stop your container:

	docker stop <CONTAINER_ID>

Running command inside the container:

	docker exec <CONTAINER_ID> <COMMAND>

Example of running command `playsmsd check` on `CONTAINER_ID` `dce34421e079`:

	docker exec dce34421e079 playsmsd check


Maintainer
----------

- Anton Raharja <araharja@protonmail.com>


References
----------

- https://github.com/tutumcloud/tutum-docker-lamp
- https://github.com/tutumcloud/tutum-docker-wordpress
