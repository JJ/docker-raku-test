FROM jjmerelo/alpine-raku:latest
LABEL version="6.0.2" maintainer="JJ Merelo <jjmerelo@GMail.com>"

ARG DIR="/test"
USER root

# Set up dirs
RUN mkdir $DIR && chown raku $DIR
VOLUME $DIR
WORKDIR $DIR

USER raku

# Will run this
ENTRYPOINT raku -v && zef install --deps-only . && zef test .


