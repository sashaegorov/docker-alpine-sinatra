# Runing tiny sinatra application on Docker

This is sample project for running a Sinatra application on Docker on top minimal Alpine Linux image.

## Usage

Create Image

```
docker build --no-cache --force-rm --rm -t alpine-sinatra app/
```

Run it !

```
export SINARTA=$(docker run --rm -p 4567:4567 -d sinatra)
echo ${SINARTA}
```

You can access it from your browser, [http://localhost:4567/](http://localhost:4567/).

Check logs.

```
docker logs $SINATRA
```

Stop it.

```
docker stop $SINATRA
```

Delete it.

```
docker rm $SINATRA
```

## OS X

Use Vagrant. In `Vagrantfile`, port forwarding setting included!

```
vagrant up
```

and

```
vagrant ssh
```

## Reference

- [OSX, Vagrant, Docker, and Sinatra | DYLI.SH](http://dyli.sh/2013/08/23/OSX-Vagrant-Docker-Sinatra.html)
- [Sinatra deployment with Docker](http://haanto.com/sinatra-deployment-with-docker/)
