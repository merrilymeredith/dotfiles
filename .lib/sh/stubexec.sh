stubexec() {
  local real_bin="$(which -a $(basename $0) | grep -v $0 | head -n 1)"
  if [ -x "$real_bin" ]; then
    exec $real_bin $*
  fi
}
