# A docker container to test Perl 6 applications

A docker container with Perl 6 for testing and continuous integration, mainly for use in Travis and other CI environments. This image should be automatically built and available at the [Docker Hub](https://hub.docker.com/r/jjmerelo/test-perl6/). It depends on the [Alpine Perl6 image](https://hub.docker.com/r/jjmerelo/alpine-perl6/), which is a Perl6 interpreter based on the lightweight Alpine distribution.

## Local use

After the usual `docker pull jjmerelo/test-perl6` do

	sudo -E  docker run -t -v /path/to/module-dir:/test jjmerelo/test-perl6 /test/module-dir/t

The local `module-dir` gets mapped to the container's `module-dir`.

## Use in Travis

Check out [this `.travis.yml`](https://github.com/JJ/perl6-Math-Sequences/blob/master/.travis.yml). It should go more or less like this

~~~
sudo: required

language: c

services:
  - docker

install:
  - docker pull jjmerelo/test-perl6
  - docker images

script: docker run -t -v /home/travis/build/[my GitHub nick]/[github repo name]:/test jjmerelo/test-perl6 
~~~

Instead of `c` you can use any other language, as long as it takes little to load. You can even eliminate it, in which case it will use Ruby, intalled by default. In fact, `docker images` is not needed either. 

In case you have to install dependencies, you'll have to change the last line to these:


~~~
script: 
  - docker run -t -v  /home/travis/build/[my GitHub nick]/[github repo name]:/test  --entrypoint="/bin/sh" jjmerelo/test-perl6  -c cd /test && zef install .
  - docker run -t -v /home/travis/build/[my GitHub nick]/[github repo name]:/test jjmerelo/test-perl6 
~~~

YOu might have to install non-Perl dependencies. Remember that you are
going to be using [Alpine Linux](https://alpinelinux.org/)
underneath. For instance, many modules use `openssl`. Add:

    - docker run -t -v  /home/travis/build/[my GitHub nick]/[github repo name]:/test  --entrypoint="/bin/sh" jjmerelo/test-perl6  -c apk add openssl-dev
	
to the `script:` section of Travis. In other, more complicated cases, you might want to try something else, but at any rate you can try and look for the name of the package in Alpine. Pretty much everything is in there. 
