ARG  CODE_VERSION=latest
FROM jjmerelo/alpine-raku:${CODE_VERSION}
LABEL version="7.0.0" maintainer="JJ Merelo <jjmerelo@GMail.com>"

ARG DIR="/test"
USER root

# Set up dirs
RUN mkdir $DIR && chown raku $DIR
COPY --chown=raku test.sh /home/raku
VOLUME $DIR
WORKDIR $DIR

USER raku

# Will run this
ENTRYPOINT ["/home/raku/test.sh"]


