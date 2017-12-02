FROM jjmerelo/alpine-perl6:latest
LABEL version="2.0" maintainer="JJ Merelo <jjmerelo@GMail.com>" perl6version="2017.11"

# Set up dirs
RUN mkdir /test
VOLUME /test
WORKDIR /test

# Will run this
ENTRYPOINT perl6 -v && prove -c -v -e "perl6 --ll-exception -Ilib"

#Basic setup
RUN apk add make curl
RUN curl -L https://cpanmin.us | perl - App::cpanminus
RUN cpanm Test::Harness --no-wget
RUN apk del make curl


# Repeating mother's env
ENV PATH="/root/.rakudobrew/bin:${PATH}"

