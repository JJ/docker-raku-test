# A docker container to test Raku applications [![Build Status](https://travis-ci.org/JJ/docker-raku-test.svg?branch=master)](https://travis-ci.org/JJ/docker-raku-test)

`jjmerelo/raku-test` is a a Docker container with Raku for testing
and continuous integration, mainly for use in Travis and other CI
environments. This image should be automatically built and available
at the [Docker Hub](https://hub.docker.com/r/jjmerelo/raku-test/). It
depends on the [Alpine Raku image](https://hub.docker.com/r/jjmerelo/alpine-perl6/), which is a
Raku interpreter based on the lightweight Alpine distribution.

This Dockerfile
is [hosted in GitHub](https://github.com/JJ/docker-raku-test). It will be
automatically rebuilt every time a new version of the alpine-perl6
image is pushed. Please raise an issue if there's any problem with it.

## Local use

After the usual `docker pull jjmerelo/raku-test` type

    docker run -t -v /path/to/module-dir:/test jjmerelo/raku-test 

The local `module-dir` gets mapped to the container's `/test` directory,
and tests are run using the usual `prove` or whatever method is
available to `zef` after installing
dependencies. 

You can also do:

    docker run -t -v  $PWD:/test jjmerelo/raku-test

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
  - docker pull jjmerelo/raku-test
  - docker images

script: docker run -t -v  $TRAVIS_BUILD_DIR:/test jjmerelo/raku-test
~~~

`docker images` is not needed, but it will show you the version it is
going to use for building. 

The base image of this container
is [Alpine Linux](https://alpinelinux.org), so any library the module
needs to install will have to be installed in this distro.

In general, the container will install all dependencies for you, but you
might want to do it separately to check for failing dependencies, for
instance.

If you need to install non-Perl dependencies, remember that you are
going to be using [Alpine Linux](https://alpinelinux.org/) underneath
in this container. For instance, many modules use `openssl-dev`. In
that case, you'll have to use this as the testing script:

    script:  docker run -t --user root --entrypoint="/bin/sh" \
      -v  $TRAVIS_BUILD_DIR:/test \jjmerelo/raku-test\
      -c "apk add --update --no-cache openssl-dev make \
      build-base && zef install --deps-only . && zef test ."

	to the `script:` section of Travis. You need to specify the root user, since this test container uses, by default, a non-privileged user. This also means that you will be running the tests as root, however. If this could be a problem, it's better if you create your own, custom, container with all needed Alpine packages installed using this one or its base.

In other, more complicated cases, you might need to build dependencies from source,
but at any rate you can try and look for the name of the package in
Alpine. Pretty much everything you might need is in
there. Use [the package search site](https://pkgs.alpinelinux.org/) to
look for the name of the package that is included in your dependencies.

Underneath, `zef` uses `prove6`. You can use it directly if you don't
have a `META6.json` file.

    script:  docker run -t  --entrypoint="/bin/sh" \
      -v  $TRAVIS_BUILD_DIR:/test jjmerelo/raku-test \
      -c "prove6 --lib"

(if there are no dependencies involved).

## See also


[The `perl6-test-openssl` container](https://hub.docker.com/r/jjmerelo/perl6-test-openssl),
which already includes OpenSSL, one of the most depended-upon modules
in the Raku ecosystem. Use that one if it's in one of your
dependencies. 

If Alpine is not convenient for you, you can try and use [the `rakudo-nostar` container)[https://hub.docker.com/r/jjmerelo/rakudo-nostar]. Using this configuration will also test:

```
language: minimal

services:
  - docker

install:
  - docker pull jjmerelo/rakudo-nostar

script: docker run --entrypoint sh -t -v  $TRAVIS_BUILD_DIR:/home/raku jjmerelo/rakudo-nostar  -c "zef install --deps-only . && zef build . && zef test ."
```
