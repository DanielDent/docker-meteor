#!/bin/sh

# If there's a .meteor/local directory we can mount on top of, we create a directory in /tmp for a bind mount.
# This allows MongoDB to acquire the lock it needs and meteor's development server to be happy with filesystem sync.

if ! [ -d /tmp/meteor-local ]; then
 mkdir /tmp/meteor-local && mount -o bind /tmp/meteor-local .meteor/local || rmdir /tmp/meteor-local
fi

exec "$@"
