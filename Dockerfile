FROM jjmerelo/alpine-perl6:latest
LABEL version="4.0.2" maintainer="JJ Merelo <jjmerelo@GMail.com>"

# Set up dirs
ENV PATH="/root/.rakudobrew/versions/moar-2019.11/install/bin:/root/.rakudobrew/versions/moar-2019.11/install/share/perl6/site/bin:/root/.rakudobrew/bin:${PATH}"
RUN mkdir /test
VOLUME /test
WORKDIR /test


# Will run this
ENTRYPOINT perl6 -v && zef install --deps-only . && zef test .


