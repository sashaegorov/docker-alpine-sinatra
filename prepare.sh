#!/bin/sh
# Localy used variables
export RACK_HOME="/home/${RACK_USER}/"

# Prerequisites
apk -U upgrade
apk add openssl ruby ruby-bundler ruby-io-console
apk add alpine-sdk ruby-dev openssl-dev

adduser -D -u 1000 ${RACK_USER}
echo "${RACK_USER} ALL=(ALL) ALL" > /etc/sudoers

cd ${RACK_HOME}
cp -r /tmp/* ${RACK_HOME}

echo 'gem: --no-document' > ~/.gemrc # http://stackoverflow.com/questions/1381725
gem update --system
gem update bundler
gem cleanup all
bundle install --clean --jobs=4
gem clean

# Mission completed
apk -U --purge del alpine-sdk openssl-dev ruby-dev
rm -vrf /var/cache/apk/*
rm -v prepare.sh
