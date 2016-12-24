# test-perl6

A docker container with Perl 6 for testing and continuous integration,
mainly for use in Travis and other CI environments.

## Local use

After the usual `docker pull jjmerelo/test-perl6` do

	sudo -E  docker run -t -v /path/to/module-dir:/test jjmerelo/test-perl6 /test/module-dir/t

The local `module-dir` gets mapped to the container's `module-dir`

## Use in Travis
