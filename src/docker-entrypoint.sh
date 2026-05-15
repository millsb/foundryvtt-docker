#!/bin/bash
# docker-entrypoint.sh — root-level wrapper
#
# Runs as root so it can fix /data ownership before dropping privileges to the
# unprivileged node user and exec-ing the real entrypoint.

set -o errexit
set -o nounset
set -o pipefail

DATA_DIR="/data"

echo "docker-entrypoint: fixing ${DATA_DIR} ownership and permissions"
chown -R node:node "${DATA_DIR}"
chmod -R 755 "${DATA_DIR}"

echo "docker-entrypoint: dropping to node user and starting entrypoint"
exec gosu node ./entrypoint.sh "$@"
