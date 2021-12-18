FROM jjmerelo/alpine-raku:latest
LABEL version="6.0.3" maintainer="JJ Merelo <jjmerelo@GMail.com>"

ARG DIR="/test"
USER root

# Set up directories
RUN mkdir $DIR && chown raku $DIR
COPY --chown=raku test.sh /home/raku
VOLUME $DIR
WORKDIR $DIR

# Change to non-privileged user
USER raku

# Will run this
ENTRYPOINT ["/home/raku/test.sh"]


