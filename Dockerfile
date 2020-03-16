FROM jjmerelo/alpine-raku:latest
LABEL version="5.0.2" maintainer="JJ Merelo <jjmerelo@GMail.com>"

# Set up dirs
RUN mkdir /test
VOLUME /test
WORKDIR /test


# Will run this
ENTRYPOINT perl6 -v && zef install --deps-only . && zef test .


