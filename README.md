# A docker container to test Perl 6 applications [![Build Status](https://travis-ci.org/JJ/test-perl6.svg?branch=master)](https://travis-ci.org/JJ/test-perl6)

`jjmerelo/test-perl6` is a a Docker container with Perl 6 for testing
and continuous integration, mainly for use in Travis and other CI
environments. This image should be automatically built and available
at the [Docker Hub](https://hub.docker.com/r/jjmerelo/test-perl6/). It
depends on the [Alpine Perl 6 image](https://hub.docker.com/r/jjmerelo/alpine-perl6/), which is a
Perl 6 interpreter based on the lightweight Alpine distribution.

This Dockerfile
is [hosted in GitHub](https://github.com/JJ/test-perl6). It will be
automatically rebuilt every time a new version of the alpine-perl6
image is pushed. Please raise an issue if there's any problem with it.

## Local use

After the usual `docker pull jjmerelo/test-perl6` type

    docker run -t -v /path/to/module-dir:/test jjmerelo/test-perl6 

The local `module-dir` gets mapped to the container's `/test` directory,
and tests are run using the usual `prove` or whatever method is
available to `zef` after installing
dependencies. 

You can also do:

    docker run -t -v  $PWD:/test jjmerelo/test-perl6

(Use `sudo` in front of `docker` if your local setup needs it).

## Use in Travis

Check out
[this `.travis.yml` as an example](https://github.com/JJ/perl6-Math-Sequences/blob/master/.travis.yml). A
generic one should go more or less like this

~~~
language:
  - minimal

services:
  - docker

install:
  - docker pull jjmerelo/test-perl6
  - docker images

script: docker run -t -v  $TRAVIS_BUILD_DIR:/test jjmerelo/test-perl6
~~~

`docker images` is not needed, but it will show you the version it is
going to use for building. 

The base image of this container
is [Alpine Linux](https://alpinelinux.org), so any library the module
needs to install will have to be installed in this distro.

In general, the container will install all dependencies for you, but you
might want to do it separately to check for failing dependencies, for
instance.

If yo need to install non-Perl dependencies, remember that you are
going to be using [Alpine Linux](https://alpinelinux.org/) underneath
in this container. For instance, many modules use `openssl-dev`. In
that case, you'll have to use this as the testing script:

    script:  docker run -t  --entrypoint="/bin/sh" \
      -v  $TRAVIS_BUILD_DIR:/test \jjmerelo/test-perl6\
      -c "apk add --update --no-cache openssl-dev make \
      build-base && zef install --deps-only . && zef test ."

to the `script:` section of Travis.

In other, more complicated cases, you might need to build from source,
but at any rate you can try and look for the name of the package in
Alpine. Pretty much everything is in
there. Use [the package search site](https://pkgs.alpinelinux.org/) to
look for the name of the package that is included in your dependencies.

Underneath, zef uses `prove6`. You can use it directly if you don't
have a `META6.json` file.

    script:  docker run -t  --entrypoint="/bin/sh" \
      -v  $TRAVIS_BUILD_DIR:/test \jjmerelo/test-perl6\
      -c "prove6 --lib"

(if there are no dependencies involved)

## See also

[The `perl6-test-openssl` container](https://cloud.docker.com/u/jjmerelo/repository/docker/jjmerelo/perl6-test-openssl),
which already includes OpenSSL, one of the most depended-upon modules
in the Perl 6 ecosystem. Use that one if it's in one of your
dependencies. 
