#!/usr/bin/env bash

# fail if a command fails
set -e
set -o pipefail

# remove apt package manager
find / -type f -iname '*apt*' -xdev -delete
find / -type d -iname '*apt*' -print0 -xdev | xargs -0 rm -r --

# set rx to all directories, except data directory/
find "$APP_DIR" -type d -exec chmod 500 {} +

# set r to all files
find "$APP_DIR" -type f -exec chmod 400 {} +
chmod -R u=rwx "$DATA_DIR/"

# chown all app files
chown "$APP_USER":"$APP_USER" -R "$APP_DIR" "$DATA_DIR"

# finally remove this file
rm "$0"
