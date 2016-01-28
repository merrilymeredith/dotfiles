#!/bin/sh
set -eu

TARGET=$1

hg archive -t tgz -p . - | ssh $TARGET tar xzv
