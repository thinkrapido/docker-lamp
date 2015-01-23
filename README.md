docker-lamp
===========

Dockerfile creating a LAMP image

## Description

This Dockerfile project creates a Docker image based on [phusion/baseimage][1] to create a predefined LAMP environment.

To create a projekt image upon it use the [thinkrapido/docker-lamp-skeleton][2].

## Usage

Get this project

```
git clone https://github.com/thinkrapido/docker-lamp.git
cd docker-lamp
chmod u+x *.sh
```

Build the image

```
sudo docker build -t lamp .
```

Now you can proceed and clone [thinkrapido/docker-lamp-skeleton][2].


[1]: https://github.com/phusion/baseimage-docker
[2]: https://github.com/thinkrapido/docker-lamp-skeleton
