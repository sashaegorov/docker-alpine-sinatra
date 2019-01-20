#!/bin/sh
# Prerequisites
apk add build-base gcc libssl1.0
cd /app
gem install bundler
bundle install --clean --deployment --without development --jobs=4

# Mission completed
apk -U --purge del build-base gcc
rm -rf ./prepare.sh /var/cache/apk/*
