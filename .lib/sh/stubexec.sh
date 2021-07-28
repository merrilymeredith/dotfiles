realpath() {
  local dir="$(dirname -- "$1")"
  local file="$(basename -- "$1")"
  (cd "$dir" 2>/dev/null && printf '%s/%s\n' "$(pwd -P)" "$file")
}

stubexec() {
  local real_me="$(realpath "$0")"
  local real_bin="$(which -a $(basename $0) | grep -v "$real_me" | head -n 1)"
  if [ -x "$real_bin" ]; then
    exec $real_bin $*
  fi
}
