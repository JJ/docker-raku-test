#!/bin/sh

raku -v
zef install --deps-only .
zef test . "$@"
