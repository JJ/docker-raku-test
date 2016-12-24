# test-perl6

A docker container with Perl 6 for testing and continuous integration,
mainly for use in Travis and other CI environments.

## Local use

After the usual `docker pull jjmerelo/test-perl6` do

	sudo -E  docker run -t -v /path/to/module-dir:/test jjmerelo/test-perl6 /test/module-dir/t

The local `module-dir` gets mapped to the container's `module-dir`

## Use in Travis

Check out [this `.travis.yml`](https://github.com/JJ/perl6-Math-Sequences/blob/master/.travis.yml). It
should go more or less like this

~~~
sudo: required

language: c

services:
  - docker

install:
  - docker pull jjmerelo/test-perl6
  - docker images

script: docker run -t -v /home/travis/build/[my GitHub nick]/[github repo name]:/test jjmerelo/test-perl6 /test/t
~~~

Instead of `c` you can use any other language, as long as it takes
little to load. You can even eliminate it, in which case it will use
Ruby, intalled by default. In fact, `docker images` is not needed
either. 

In case you have to install dependencies, you'll have to change the
last line to these:


~~~
script: 
  - docker run -t -v  /home/travis/build/[my GitHub nick]/[github repo name]:/test  --entrypoint="/bin/sh" jjmerelo/test-perl6  -c cd /test && panda installdeps .
  - docker run -t -v /home/travis/build/[my GitHub nick]/[github repo name]:/test jjmerelo/test-perl6 /test/t
~~~
