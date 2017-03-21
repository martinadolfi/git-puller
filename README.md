# Description

This container will clone the specified git repo to `/src`.

`/src` will be a volume that's intended to be mounted with `volumes_from` to/from other containers.

You have to specify the repository with the environment variable `REPO`, the branch with the environment variable `BRANCH` and the directory where to clone on with the environment variable `MYDIR`.

# Examples

## Directly running docker run

```bash
docker run -e MYDIR=/var/www -e BRANCH=master -e REPO=https://github.com/martinadolfi/basichttp.git git-puller
```

## Directly running on docker-compose

```yaml
version: '2'
services:
  git:
    image: martinadolfi/git-puller
    environment:
      BRANCH: master
      REPO: https://github.com/martinadolfi/basichttp.git
      MYDIR: /usr/local/apache2/htdocs
    volumes:
      - /usr/local/apache2/htdocs
  web:
    image: httpd
    volumes_from:
      - git
    ports:
      - "80:80"
```
```bash
docker-compose up -d
```

### And what if I need to pull again??

Just do this:

```bash
docker-compose start git
```

It'll pull again

# How about cloning a private repo!?

Well, the startup script creates a set of keys when it starts, and it'll show the key for you in the logs, so if you do `docker logs` with the name of the container after running it the first time, it'll tell you your key. You'll put that key as a deployment key in you repo and voila.
