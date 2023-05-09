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
  try_nix "$@"
  try_install_callback
  stubexec "$@"
}

has() {
  type "$1" >/dev/null 2>&1
}

try_nix() {
  [ "${nix_ref:-}" ] && has nix || return 1
  local installed_slot="$(
    nix profile list | perl -anE 'BEGIN { $m = shift =~ s/#/#.+/r } say $F[0] if $F[1] =~ $m' "$nix_ref"
  )"
  if [ "$installed_slot" ]; then
    nix profile upgrade "$installed_slot"
  else
    nix profile install "$nix_ref"
  fi
  # skip age check
  exec "$(realbin "$0")" "$@"
  # FIXME: so right now, this works but will check for upgrades every run past
  # the age check
}

try_install_callback() {
  install_it
  touch "$(realbin "$0")"  # In case of no updates
}

bina_install() {
  local github_repo="$1"
  mkdir -p ~/.local/bin
  cd ~/.local/bin
  curl -fsSL "https://bina.egoist.dev/${github_repo}?dir=." | sh
  cd -
}

stubexec "$@"
