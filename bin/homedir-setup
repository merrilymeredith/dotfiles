#!/bin/sh

set -eu

if ! git --version >/dev/null; then
  echo "Please install git!"
  exit 1
fi

pull () {
  echo "$1:"
  git -C $1 pull --no-tags
}

if ! [ -d .zgen ]; then
  git clone https://github.com/tarjoilija/zgen.git .zgen
else
  pull .zgen
fi

if ! [ -d .plenv ]; then
  git clone https://github.com/tokuhirom/plenv.git .plenv
  git clone https://github.com/tokuhirom/Perl-Build.git .plenv/plugins/perl-build/
else
  pull .plenv
  pull .plenv/plugins/perl-build
fi

if ! [ -d .rbenv ]; then
  git clone https://github.com/sstephenson/rbenv.git .rbenv
  git clone https://github.com/sstephenson/ruby-build.git .rbenv/plugins/ruby-build/
else
  pull .rbenv
  pull .rbenv/plugins/ruby-build
fi

if ! [ -d .ndenv ]; then
  git clone https://github.com/riywo/ndenv.git .ndenv
  git clone https://github.com/riywo/node-build.git .ndenv/plugins/node-build
else
  pull .ndenv
  pull .ndenv/plugins/node-build
fi

