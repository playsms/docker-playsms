docker-playsms
==============

This project is playSMS docker image project.

playSMS is a free and open source SMS management software. A flexible Web-based mobile portal system that it can be made to fit to various services such as an SMS gateway, bulk SMS provider, personal messaging system, corporate and group communication tools.

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

	docker run -d -p 2222:22 -p 80:80 antonraharja/playsms

Get `<CONTAINER_ID>` of your image:

	docker ps -l

Follow logs:

	docker logs -f <CONTAINER_ID>

Once `sshd` runs, change the default shell or SSH root password:

	ssh -p 2222 root@localhost
	passwd root

Change the password to your own secure password. The default shell or SSH root password is `changemeplease`


Usage
-----

Start your container:

	docker start <CONTAINER_ID>

Stop your container:

	docker stop <CONTAINER_ID>

Running command inside the container:

	docker exec <CONTAINER_ID> <COMMANDS>

Example of running command `playsmsd check` on `CONTAINER_ID` `dce34421e079`:

	docker exec dce34421e079 playsmsd check


Maintainer
----------

- Anton Raharja <antonrd@gmail.com>


References
----------

- https://github.com/tutumcloud/tutum-docker-lamp
- https://github.com/tutumcloud/tutum-docker-wordpress
