#!/bin/ash -xe

NICE='nice -n 19'
#NUMA='numactl --interleave=all'

exec $NICE $NUMA monerod "$@" --rpc-bind-ip=0.0.0.0 --confirm-external-bind
