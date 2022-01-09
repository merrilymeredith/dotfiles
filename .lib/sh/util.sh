warn() { echo "$*" >&2; }
die() { warn "$*"; exit 1; }

clone_or_pull() {
  if ! [ -d $2 ]; then
    git clone --single-branch --depth 1 "$1" $2
  else
    echo "$2:"
    git -C "$2" pull
  fi
}
