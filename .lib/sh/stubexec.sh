cache="${XDG_CACHE_HOME:-$HOME/.cache}/stubexec"

stubexec() {
  mkdir -p "$cache"

  local real_bin="$(realbin "$0")"
  if [ ! -x "$real_bin" ] || age_check $0; then
    install_it
    touch_checktime "$0"
    stubexec "$@"
  fi
  exec "$real_bin" "$@"
}

touch_checktime() {
  kv "$cache/db" touch "$(basename $1)"
}

age_check() {
  kv "$cache/db" age_days_gt "$(basename $1)" "${age_limit:-90}"
}

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

realbin() {
  local bn="$(basename $1)"
  which -a "$bn" |
    grep -v "$(realpath $1)" |
    shim_filter "$bn" |
    head -n 1
}

has() {
  type "$1" >/dev/null 2>&1
}

bina_install() {
  local github_repo="$1"
  mkdir -p ~/.local/bin
  cd ~/.local/bin
  curl -fsSL "https://bina.egoist.dev/${github_repo}?dir=." | sh
  cd -
}

stubexec "$@"
