Starting it with the host docker sock :

```
$ docker run --rm -it -v /var/run/docker.sock:/var/run/docker.sock devbox
```

Now you can send Docker commands to the same instance of the Docker daemon you are using on the host - inside your container.

Inside the container, you can use other images/containers that are on the host:

```
$ docker run --rm -it \
  -v /home/tb/Code/ruby:/usr/src/app \
  -w /usr/src/app \
  ruby:rc-alpine \
  ruby hello.rb
```

Remarks:
- the `/home/tb/Code/ruby` path is located on the host
