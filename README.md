# boot2docker-build-script
An AppleScript to build and run your image.

## Usage
1. Create a directory by a name of image you want to build.
2. Put your Dockerfile and this script into it.
3. Run boot2docker-build-script.applescript.
```
[ImageName]
|-- Dockerfile
|-- boot2docker-build-script.applescript
```

## Mechanism
1. Running commands for boot2docker.
```
$ boot2docker init (if needed)
$ boot2docker up (if needed)
$ boot2docker ssh
```
2. Changing the working directory to the location of this script on host.(Using folder sharing provided by boot2docker)
3. Building an image with directory name as image name.
4. To check the built image, running /bin/bash with -it option.(interactive, Pseudo-tty)
