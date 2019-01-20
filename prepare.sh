#!/bin/sh
# Prerequisites
apk add build-base gcc libstdc++ libssl1.0
cd /app

# Install stuff
gem install bundler
bundle install --deployment --without development --jobs=4
bundle clean --force

# Clean up
apk -U --purge del build-base gcc
rm -rf ./prepare.sh /var/cache/apk/* /root/.bundle /root/.gem
