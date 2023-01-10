#!/usr/bin/env sh

set -e

while [[ $# -gt 0 ]]
do
key="$1"

case $key in
    --hostname)
    HOSTNAME=$2
    shift
    shift
    ;;
    --port)
    PORT=$2
    shift
    shift
    ;;
    --username)
    USERNAME=$2
    shift
    shift
    ;;
    *) # unknown option
    exit 1
    ;;
esac
done

HOSTNAME=${HOSTNAME:?}
PORT=${PORT:?}
USERNAME=${USERNAME:?}

TOKEN=$(aws rds generate-db-auth-token --hostname ${HOSTNAME:?} --port ${PORT:?} --username ${USERNAME:?} )

echo '{"token": "'${TOKEN:?}'"}'
