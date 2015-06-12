#!/bin/bash

set -euo pipefail
IFS=$'\n\t'

if [ ! -L ~/userprofile ]; then
  echo "Please link ~/userprofile"
fi

USERPROFILE="$(readlink ~/userprofile)"

cd `hg root`

cp -vu .vimrc ${USERPROFILE}/_vimrc

if [ ! -d ${USERPROFILE}/vimfiles ]; then
  mkdir ${USERPROFILE}/vimfiles
fi

cp -vuRL -t ${USERPROFILE}/vimfiles .vim/*

# rebuilding vimproc dll on babun for w32 gvim:
# $ pact install mingw-gcc-core
# $ make -f make_mingw32.mak CC=i686-pc-mingw32-gcc


