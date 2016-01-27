#!/bin/sh
set -eu

hg archive -t tgz -p . - | ssh $1 tar xzv
