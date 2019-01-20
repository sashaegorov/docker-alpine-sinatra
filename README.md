# Sinatra in Docker

[Alpine Sinatra](https://hub.docker.com/r/sashaegorov/docker-alpine-sinatra) is a tiny Sinatra application which runs in Docker on top minimalistic Alpine Linux image.

### How to run it
```
docker run -d -p 5678:5678 sashaegorov/docker-alpine-sinatra
docker ps
``` 

### How to create image locally

```  
docker build --no-cache \
--force-rm --rm \
--tag alpine-sinatra .
```

Consider remove some options if you know how they works e.g. `--no-cache`, `--force-rm` and `--rm`.

Run and check image
```
docker run -d -p 5678:5678 alpine-sinatra
docker ps
```

If `Vagrant` is up and running, it is possible  to access application via forwarded port right in your [browser](http://localhost:5678). Check available endpoints:
- [/env[?json=yes]](http://localhost:5678/env) environment details
- [/disk](http://localhost:5678/disk) output of `df -h`
- [/memory](http://localhost:5678/memory) output of `free -m`
- [/exit](http://localhost:5678/exit) send TERM signal to app
- [/fail](http://localhost:5678/fail) send KILL signal
- [/sleep[?seconds=3.5]](http://localhost:5678/sleep?seconds=3.14) artificial delay 
- [/form](http://localhost:5678/form) simple form with POST method

Run `docker ps` to obtain container ID and export it e.g. `export SINATRA=2a3740f25d4b`

Check out logs.

```
docker logs $SINATRA
docker logs -f $SINATRA # follow new logs
```

Stop it (takes 10 seconds by default)

```
docker stop $SINATRA
```

Delete it.

```
docker rm $SINATRA
```

Clean up after it

```
docker images | grep '<none>' | awk '{print $3}' | xargs docker rmi -f
```

Clean up all images

```
docker rm $(docker ps -a -q)
docker rmi $(docker images -q)
```

Check image size
```
docker image inspect alpine-sinatra:latest --format='{{.Size}}'
```

For development purposes you can run it locally without Docker (note another port is used to avoid conflicts)

```
rerun 'bundle exec rackup -o 0.0.0.0 -p 5679'
```


### If you are on macOSX

Just use Vagrant. Run and login into Vagrant box:
```
vagrant up && vagrant ssh  
```
After successful login:
```
cd /vagrant
```
Check `Vagrantfile` content for more information and configuration details.

### Playing with `curl`

Here `http://localhost:5678/form` is default development URL if application was started with `rackup app/sinatra/config.ru`.

```
curl --form 'message=Hello world!✔︎' --form 'log=yes' http://localhost:5678/form
Hello world!✔︎⏎
```

### If things went wrong

Login into Docker container:

```
docker run -ti -p 5678:5678 alpine-sinatra /bin/sh
```

And figure out what's wrong...
