#!/bin/bash
set -m

cmd="mongod --auth"

$cmd &

/configMongo.sh

fg