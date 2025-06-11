venv() {
  local venv_home="${VENV_HOME:-$HOME/.venvs}"
  local venv="${1:?Please provide venv name}"

  source "$venv_home/$venv/bin/activate"
}

lsvenv() {
  local venv_home="${VENV_HOME:-$HOME/.venvs}"
  ls -1 "$venv_home"
}

mkvenv() {
  local venv_home="${VENV_HOME:-$HOME/.venvs}"
  local venv="${1:?Please provide venv name}"

  if [[ -d "$venv_home/$venv" ]]; then
    echo "venv $venv already exists" >&2
    return
  fi

  mkdir -p "$venv_home"
  python3 -m venv "$venv_home/$venv"
}

rmvenv() {
  local venv_home="${VENV_HOME:-$HOME/.venvs}"
  local venv="${1:?Please provide venv name}"

  if [[ ! -d "$venv_home/$venv" ]]; then
    echo "venv $venv does not exist" >&2
    return
  fi

  rm -rf "$venv_home/$venv"
}
