FROM jjmerelo/alpine-perl6:latest
LABEL version="4.0.2" maintainer="JJ Merelo <jjmerelo@GMail.com>"

# Set up dirs
RUN mkdir /test
VOLUME /test
WORKDIR /test


# Will run this
ENTRYPOINT perl6 -v && zef install --deps-only . && zef test .


