FROM jjmerelo/alpine-raku:latest
LABEL version="6.0.4" maintainer="JJ Merelo <jjmerelo@GMail.com>"

ARG DIR="/test"
USER root

# Set up testing dir and script
RUN mkdir $DIR && chown raku $DIR
COPY --chown=raku test.sh /home/raku

WORKDIR $DIR

# Change to non-privileged user
USER raku

# Will run this
ENTRYPOINT ["/home/raku/test.sh"]


