#!/bin/bash
set -e
set -x

# Checking variables
echo "Checking environment..."
echo "Locale: ${LOCALE}"
echo "Current user: `whoami`"
echo "RACK user: ${RACK_USER}"
echo "RACK environment: ${RACK_ENV}"

echo 'Installing `gosu` utility...'

# Localy used variables
export RUBY_MAJOR=2.2
export RUBY_VERSION="${RUBY_MAJOR}.3"

export RACK_HOME="/${RACK_USER}"

export RUBY_CONFIGURE_OPTS='--enable-shared=true'

export APT_OPTS_INSTALL='-y --force-yes --no-install-recommends'
export APT_OPTS_UNINSTALL='-y --auto-remove'
export APT_PACKAGES_UTILS='ca-certificates curl wget git debconf-utils apt-utils'
export APT_PACKAGES_BUILD='patch bzip2 gawk g++ gcc make libc6-dev libreadline6-dev zlib1g-dev libssl-dev libyaml-dev libsqlite3-dev sqlite3 autoconf libgdbm-dev libncurses5-dev automake libtool bison pkg-config libffi-dev libxml2-dev libxslt-dev'

# Getting packages info
apt-get update
# Make preconfiguration possible
apt-get install ${APT_OPTS_INSTALL} ${APT_PACKAGES_UTILS}
export DEBIAN_FRONTEND=noninteractive

# Get gosu https://github.com/tianon/gosu/
wget -O /usr/local/bin/gosu "https://github.com/tianon/gosu/releases/download/1.4/gosu-$(dpkg --print-architecture)"
chmod +x /usr/local/bin/gosu

# System locales
export LANG=C # fallback to C temporary
echo 'Installing locales...'
cat << LOCALE | debconf-set-selections
locales locales/default_environment_locale select ${LOCALE}
locales locales/locales_to_be_generated multiselect ${LOCALE} UTF-8
LOCALE

echo 'Check locales preconfiguration...'
debconf-get-selections | grep '^locales'

apt-get install -y locales
dpkg-reconfigure locales

# Setting and checking locale
echo 'Check available locales ...'
locale -a
export LANGUAGE=${LOCALE}
export LANG=${LOCALE}
export LC_ALL=${LOCALE}
echo 'Check current locale ...'
locale

cat << LOCALE | debconf-set-selections
localepurge localepurge/nopurge multiselect ${LOCALE}
localepurge localepurge/quickndirtycalc boolean true
localepurge localepurge/mandelete boolean true
localepurge localepurge/showfreedspace boolean true
localepurge localepurge/remove_no note
localepurge localepurge/none_selected boolean false
localepurge localepurge/use-dpkg-feature boolean false
localepurge localepurge/verbose boolean false
LOCALE

echo 'Check localepurge preconfiguration...'
debconf-get-selections | grep ^localepurge

apt-get install ${APT_OPTS_INSTALL} localepurge
dpkg-reconfigure localepurge

# TODO: Remove Documentation
# - All Gems

# # If you need some build dependency for gem, add it here.
apt-get install ${APT_OPTS_INSTALL} ${APT_PACKAGES_BUILD}

# Add our user and group first
echo "Adding Rack user ${RACK_USER}..."
groupadd -r ${RACK_USER} && useradd -r -d ${RACK_HOME} -g ${RACK_USER} ${RACK_USER}

# Getting and conpillimg Ruby
wget -P ${RACK_HOME} http://cache.ruby-lang.org/pub/ruby/${RUBY_MAJOR}/ruby-${RUBY_VERSION}.tar.bz2
cd ${RACK_HOME} && tar xf ruby-${RUBY_VERSION}.tar.bz2

# Want ./configure --quiet ?
export RUBY_CONFIGURE_OPTS="${RUBY_CONFIGURE_OPTS} --quiet"
# Save extra space
export RUBY_CONFIGURE_OPTS="${RUBY_CONFIGURE_OPTS} --disable-install-doc"
#
cd ${RACK_HOME}/ruby-${RUBY_VERSION} && \
./configure ${RUBY_CONFIGURE_OPTS} && \
make install

chown -R ${RACK_USER} ${RACK_HOME} # setting permissions

which ruby && ruby --version
gem update --system
gem install bundler && gem cleanup

cd /sinatra && bundle install --clean --jobs=4
# Uninstall Everything!
echo "Cleaning..."
rm -rf ${RACK_HOME}/ruby-${RUBY_VERSION}* # Remove sources

localepurge # Remove locales if any
# Purge packages
# apt-get purge ${APT_OPTS_UNINSTALL} ${APT_PACKAGES_BUILD}
apt-get purge ${APT_OPTS_UNINSTALL} localepurge ${APT_PACKAGES_UTILS}
apt-get clean -y && apt-get autoclean -y && apt-get autoremove -y

rm -rf /var/lib/{apt,dpkg,cache,log}/ # makes impossible to use apt utilities
rm -rf /usr/share/{man,doc}
rm -rf /var/cache/debconf/*-old
exit
