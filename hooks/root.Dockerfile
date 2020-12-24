ARG  CODE_VERSION
FROM jjmerelo/alpine-raku:${CODE_VERSION}
LABEL version="7.0.1" maintainer="JJ Merelo <jjmerelo@GMail.com>"
ARG  CODE_VERSION

ARG DIR="/test"

# Set up dirs
RUN echo "Building from version ${CODE_VERSION}"\
    && mkdir $DIR\
    && mkdir -p /home/raku

COPY test.sh /home/raku
VOLUME $DIR
WORKDIR $DIR

# Will run this
ENTRYPOINT ["/home/raku/test.sh"]


