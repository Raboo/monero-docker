#!/bin/ash -xe

NICE="${NICE:-nice -n 19}"
MONEROD="monerod $@ --rpc-bind-ip=0.0.0.0 --confirm-external-bind"

if [[ "${1:0:1}" = '-' ]] || [[ -z "$@" ]]; then
  set -- $NICE $MONEROD
else
  set -- "$@"
fi

exec "$@"
