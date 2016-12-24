FROM jjmerelo/alpine-perl6:latest
MAINTAINER JJ Merelo <jjmerelo@GMail.com>
ENTRYPOINT cd /test/; echo perl6 -v; prove -v -e "perl6 --ll-exception -Ilib"

#Basic setup
RUN cpan App::cpanminus
RUN cpanm Test::Harness --no-wget

# Set up dirs
RUN mkdir /test
VOLUME /test

# Repeating mother's env
ENV PATH="/root/.rakudobrew/bin:${PATH}"

