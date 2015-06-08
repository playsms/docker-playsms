docker-playsms
==============

Out-of-the-box playSMS docker image


Usage
-----

To create the image `antonraharja/playsms`, execute the following command on the docker-playsms folder:

	docker build -t antonraharja/playsms .

You can now push your new image to the registry:

	docker push antonraharja/playsms


Running your playSMS docker image
---------------------------------

Start your image:

	docker run -d -p 80:80 antonraharja/playsms

Test your deployment:

	curl http://localhost/

You can now start configuring your playSMS container
