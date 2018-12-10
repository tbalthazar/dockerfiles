# Devbox

## Build

```
$ docker build -t tbalthazar/devbox:0.1 .
```

## Run with access to Docker from host

```
$ docker run --rm -it \
  -v /var/run/docker.sock:/var/run/docker.sock \
  -h devbox \
  -u $UID:$(stat -c %g /var/run/docker.sock) \
  --name devbox
  devbox
```

By giving it the same group id as the docker group on the host, we make sure the user can run `docker` without sudo from the container. (https://medium.com/@mccode/understanding-how-uid-and-gid-work-in-docker-containers-c37a01d01cf, https://medium.com/@mccode/processes-in-containers-should-not-run-as-root-2feae3f0df3b)

## Run the container to edit a Rails project

```
$ docker run --rm -it \
  -h devbox \
  -u $UID:$(stat -c %g /var/run/docker.sock) \
  -v /var/run/docker.sock:/var/run/docker.sock \
  -v /home/tb/Code/sites/byrecords.com:/code \
  -v /tmp/gems:/gems \
  -e BUNDLE_PATH=/gems \
  -e GEM_HOME=/gems \
  -p 3000:3000 devbox
```

## Run

```
$ docker run --rm -it -user tb tbalthazar/devbox:0.1
```

## Run for a Rails project

```
$ docker run --rm -it \
  -v $(pwd):/home/tb/hello-rails \
  -v /tmp/gems:/gems \
  -e BUNDLE_PATH=/gems \
  -e GEM_HOME=/gems \
  -h devbox \
  tbalthazar/devbox:0.1
```

## Run the Rails project

```
$ docker run --rm -it \
  -p 3000:3000 \
  -v $(pwd):/usr/src/app \
  -v /tmp/gems:/gems \
  -h hello-rails \
  tbalthazar/hello-rails
```

Example Dockerfile for the Rails app:

```
FROM ruby:2.5.3
LABEL maintainer=thomas@balthazar.info

COPY Gemfile* /usr/src/app/
WORKDIR /usr/src/app

ENV BUNDLE_PATH /gems
ENV GEM_HOME /gems
ENV PATH "${BUNDLE_PATH}/bin:${PATH}"
RUN apt-get update && apt-get install -y \
  nodejs \
  --no-install-recommends \
  && bundle install
COPY . /usr/src/app
CMD ["rails", "s", "-b", "0.0.0.0"]
```

## How it should work

- start the Rails container -> should fail because no gem is insalled (since /tmp/gems is mounted and is currently empty)
- start the devenv and run `bundle install`
- everything should be installed in /tmp/gems, but when I run the Rails container, I seen an error about nokogiri (when doing `gem list` in the Rails container I see that native extensions are missing
