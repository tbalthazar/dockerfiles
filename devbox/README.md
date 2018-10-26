# Devbox

## Build

```
$ docker build -t tbalthazar/devbox:0.1 .
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
  tbalthazar/devbox:0.1
```

## Run the Rails project

```
$ docker run --rm -it \
  -p 3000:3000 \
  -v $(pwd):/usr/src/app \
  -v /tmp/gems:/gems \
  hello-rails
```
