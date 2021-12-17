FROM jjmerelo/alpine-raku:latest
LABEL version="6.0.3" maintainer="JJ Merelo <jjmerelo@GMail.com>"

ARG DIR="/test"
USER root

# Set up dirs
RUN mkdir $DIR && chown raku $DIR && mkdir /__w \
        && chown raku /__w && chmod 777 /__w
COPY --chown=raku test.sh /home/raku
VOLUME $DIR
WORKDIR $DIR

# Change to non-privileged user
USER raku

# Will run this
ENTRYPOINT ["/home/raku/test.sh"]


