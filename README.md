docker-playsms
==============

This project is playSMS docker image project.

playSMS is a free and open source SMS management software. A flexible Web-based mobile portal system that it can be made to fit to various services such as an SMS gateway, bulk SMS provider, personal messaging system, corporate and group communication tools.

Visit [playSMS](http://playsms.org) website for more information.


To Build or To Get
------------------

You can build your own image from this project or run from a ready-to-use image from docker hub

## To build an image

To build the image `yourname/playsms`, execute the following command on the `docker-playsms` folder:

	docker build -t yourname/playsms .

You can now push your new image to the registry:

	docker push yourname/playsms

## To get a ready-to-use image

Pull/download the image from docker hub:

	docker pull antonraharja/playsms


Install and Run
---------------

Run this once for installation:

	docker run -d -p 2222:22 -p 80:80 yourname/playsms

Or run this instead if you pull the image form docker hub:

	docker run -d -p 2222:22 -p 80:80 antonraharja/playsms

Get `<CONTAINER_ID>` of your image:

	docker ps -l

Start your container:

	docker start <CONTAINER_ID>

Stop your container:

	docker stop <CONTAINER_ID>

Follow logs:

	docker logs <CONTAINER_ID>

Once `sshd` runs, change the default shell or SSH root password:

	ssh -p 2222 root@localhost
	passwd root

The default shell or SSH root password is `changemeplease`


Maintainer
----------

- Anton Raharja <antonrd@gmail.com>


References
----------

- https://github.com/tutumcloud/tutum-docker-lamp
- https://github.com/tutumcloud/tutum-docker-wordpress
