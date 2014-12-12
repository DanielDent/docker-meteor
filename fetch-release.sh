#!/bin/sh

# This script downloads the currently published installer +
# tarballs for the specified meteor version and outputs their checksums.

[ "$#" -ne 1 ] && echo Usage: $0 METEOR_VERSION && exit 1

RELEASE=$1
DOWNLOAD_DIR=$(mktemp -d -t meteor-tarballs)

echo Downloading Meteor ${RELEASE} and placing in ${DOWNLOAD_DIR}

curl -SL https://install.meteor.com/ -o ${DOWNLOAD_DIR}/installer-${RELEASE}.sh
shasum -a 256 ${DOWNLOAD_DIR}/installer-${RELEASE}.sh

for PLATFORM in os.linux.x86_32 os.linux.x86_64; do
  TARBALL_URL=https://d3sqy0vbqsdhku.cloudfront.net/packages-bootstrap/${RELEASE}/meteor-bootstrap-${PLATFORM}.tar.gz
  curl -SL ${TARBALL_URL} -o ${DOWNLOAD_DIR}/meteor-bootstrap-${PLATFORM}-${RELEASE}.tar.gz
  shasum -a 256 ${DOWNLOAD_DIR}/meteor-bootstrap-${PLATFORM}-${RELEASE}.tar.gz
done

