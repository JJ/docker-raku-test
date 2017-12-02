FROM jjmerelo/alpine-perl6:latest
LABEL version="2.0"
MAINTAINER JJ Merelo <jjmerelo@GMail.com>
ENTRYPOINT cd /test/; echo perl6 -v; prove -v -e "perl6 --ll-exception -Ilib"

#Basic setup
RUN apk add make && cpan App::cpanminus && cpanm Test::Harness --no-wget
RUN apk del make

# Set up dirs
RUN mkdir /test
VOLUME /test

# Repeating mother's env
ENV PATH="/root/.rakudobrew/bin:${PATH}"

