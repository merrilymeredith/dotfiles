realpath() {
  local dir="$(dirname -- "$1")"
  local file="$(basename -- "$1")"
  (cd "$dir" 2>/dev/null && printf '%s/%s\n' "$(pwd -P)" "$file")
}

realbin() {
  which -a $(basename $1) |
    grep -v "$(realpath $1)" |
    head -n 1
}

stubexec() {
  local real_bin="$(realbin "$0")"
  if [ -x "$real_bin" ]; then
    exec "$real_bin" $*
  fi
  install_it
  stubexec $*
}
