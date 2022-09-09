realpath() {
  local dir="$(dirname -- "$1")"
  local file="$(basename -- "$1")"
  (cd "$dir" 2>/dev/null && printf '%s/%s\n' "$(pwd -P)" "$file")
}

shim_filter() {
  local binpath=''
  while read binpath; do
    case "$binpath" in
      */.plenv/shims/*)
        plenv which $1 >/dev/null 2>&1 || continue
        ;;
      */.asdf/shims/*)
        asdf which $1 >/dev/null 2>&1 || continue
        ;;
    esac
    echo "$binpath"
  done
}

age_check() {
  local subject=''
  read subject
  find "$subject" -mtime -${age_limit:-90} -print
}

realbin() {
  local bn="$(basename $1)"
  which -a "$bn" |
    grep -v "$(realpath $1)" |
    shim_filter "$bn" |
    head -n 1
}

stubexec() {
  local real_bin="$(realbin "$0" | age_check)"
  if [ -x "$real_bin" ]; then
    exec "$real_bin" "$@"
  fi
  install_it
  touch "$(realbin "$0")"  # In case of no updates
  stubexec "$@"
}

stubexec "$@"
