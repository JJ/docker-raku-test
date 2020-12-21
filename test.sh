#!/bin/sh

zef install --deps-only .
zef test . "$@"
