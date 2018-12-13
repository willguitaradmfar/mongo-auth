#!/bin/bash
set -m

cmd="mongod --auth --bind_ip_all"

$cmd &

/configMongo.sh

fg
