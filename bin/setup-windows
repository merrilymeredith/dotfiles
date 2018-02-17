#!/bin/sh
set -eu

if [ ! -L ~/userprofile ]; then
  echo "Please link ~/userprofile"
fi

USERPROFILE="$(readlink ~/userprofile)"

cd `hg root`

mkdir -p ${USERPROFILE}/vimfiles

cp -vu .vimrc ${USERPROFILE}/_vimrc

cp -vuRL -t ${USERPROFILE}/vimfiles .vim/*

cp -vuRL -t ${USERPROFILE}/ \
  .lib \
  .ctags \
  .perltidyrc \
  .replyrc

mkdir -p ${USERPROFILE}/{css,js}
cp -vuRL -t ${USERPROFILE}/css .css/*
cp -vuRL -t ${USERPROFILE}/js .js/*

cat <<ENDINSTR
#  rebuilding vimproc dll on babun for w32 gvim:
#  $ pact install mingw-gcc-core
#  $ make -f make_mingw32.mak CC=i686-pc-mingw32-gcc

#  for w64 gvim:
#  $ pact install mingw64-x86_64-gcc-core
#  $ make -f make_mingw64.mak CC=x86_64-w64-mingw32-gcc
ENDINSTR
