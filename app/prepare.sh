#!/bin/sh
# Localy used variables
export RACK_HOME="/app"
export RACK_ENV="development"
# Prerequisites
apk -U add alpine-sdk openssl-dev ruby-dev openssl-dev
apk add -U ruby ruby-bundler ruby-io-console
echo 'gem: --no-document' > ~/.gemrc #http://stackoverflow.com/questions/1381725
cd ${RACK_HOME} && \
bundle install --clean --jobs=4 && \
gem clean
# Mission completed
apk -U --purge del alpine-sdk openssl-dev ruby-dev openssl-dev
rm -vrf /var/cache/apk/*
rm -v $0
