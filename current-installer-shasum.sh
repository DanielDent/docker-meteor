#!/bin/sh

# Usage: ./current-installer-sha256.sh

# The Dockerfile checks that our assumptions about the meteor installer are
# still valid by putting the installer into its apparent canonical form and
# validating its checksum. This script outputs the checksum of the canonical
# form of the currently published installer.

curl -SL https://install.meteor.com/ | \
 sed -e "s/^RELEASE=.*/RELEASE=\"\$METEOR_VERSION\"/" | \
 shasum -a 256 | \
 cut -f1 -d' '
 
