docker-playsms
==============

This project is playSMS docker image project.

playSMS is a free and open source SMS management software.

A flexible Web-based mobile portal system that it can be made to fit to various services such as an SMS gateway, bulk SMS provider, personal messaging system, corporate and group communication tools.


Build image
-----------

To build the image `yourname/playsms`, execute the following command on the `docker-playsms` folder:

	docker build -t yourname/playsms .

You can now push your new image to the registry:

	docker push yourname/playsms


Get ready-to-use image
----------------------

Pull/download the image from docker registry:

	docker pull antonraharja/playsms


Running playSMS docker image
---------------------------------

Run this once for installation:

	docker run -d -p 80:80 antonraharja/playsms

Get CONTAINER_ID of your image:

	docker ps -l

To start your container:

	docker start <CONTAINER_ID>

To stop your container:

	docker stop <CONTAINER_ID>


References
----------

- https://github.com/tutumcloud/tutum-docker-lamp
- https://github.com/tutumcloud/tutum-docker-wordpress
