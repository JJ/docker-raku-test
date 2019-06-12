FROM jjmerelo/alpine-perl6:latest
LABEL version="4.0.1" maintainer="JJ Merelo <jjmerelo@GMail.com>"

# Set up dirs
ENV PATH=/root/.rakudobrew/bin/../versions/moar-2019.03.1/install/bin:/root/.rakudobrew/bin/../versions/moar-2019.03.1/install/share/perl6/site/bin:/root/.rakudobrew/bin:/root/.rakudobrew/moar-2019.03.1/install/share/perl6/site/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
RUN mkdir /test
VOLUME /test
WORKDIR /test


# Will run this
ENTRYPOINT perl6 -v && zef install --deps-only . && zef test .


