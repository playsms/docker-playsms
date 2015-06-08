docker-playsms
==============

playSMS is a free and open source SMS management software. A flexible Web-based mobile portal system that it can be made to fit to various services such as an SMS gateway, bulk SMS provider, personal messaging system, corporate and group communication tools.

This project is playSMS docker image project.


Modify image
------------

To create the image `antonraharja/playsms`, execute the following command on the `docker-playsms` folder:

	docker build -t antonraharja/playsms .

You can now push your new image to the registry:

	docker push antonraharja/playsms


Running your playSMS docker image
---------------------------------

Run this once during installation:

	docker run -d -p 80:80 antonraharja/playsms

Get CONTAINER_ID:

	docker ps -l

Next time, start your container:

	docker start <CONTAINER_ID>


References
----------

https://github.com/tutumcloud/tutum-docker-lamp
https://github.com/tutumcloud/tutum-docker-wordpress
