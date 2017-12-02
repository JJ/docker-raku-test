FROM jjmerelo/alpine-perl6:latest
LABEL version="2.0" maintainer="JJ Merelo <jjmerelo@GMail.com>"
ENTRYPOINT cd /test/; echo perl6 -v; prove -v -e "perl6 --ll-exception -Ilib"

#Basic setup
RUN apk add make curl
RUN curl -L https://cpanmin.us | perl - --sudo App::cpanminus
RUN cpanm Test::Harness --no-wget
RUN apk del make curl

# Set up dirs
RUN mkdir /test
VOLUME /test

# Repeating mother's env
ENV PATH="/root/.rakudobrew/bin:${PATH}"

