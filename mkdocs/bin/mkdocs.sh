#!/bin/sh

# Set error handling
set -eu

################################################
## Common functions
################################################

if [ -z "$0" ] ; then
  echo "Cannot determine script path"
  exit 1
fi

script_dir="$(cd "$(dirname "$0")" && pwd)"

# Ensure the script is running inside a Docker container
test -f /.dockerenv || {
  echo "This script is intended to be run inside a Docker container."
  exit 1
}

# Handle Ctrl + C gracefully
trap ctrl_c INT

ctrl_c () {
  code="$?"
  printf "[%s] Ctrl + C happened\n" "$(date +'%Y-%m-%d %H:%M:%S')"
  test $code -gt 1 || code=0
  if [ $code -eq 0 ] ; then
    printf "[%s] Shutting down gracefully ...\n" "$(date +'%Y-%m-%d %H:%M:%S')"
  else
    printf "[%s] Exiting with error code %d ...\n" "$(date +'%Y-%m-%d %H:%M:%S')" "$code"
  fi
  exit $code
}

################################################
## Main functions
################################################

cd /root

PORT="${PORT:-8000}"

if [ -f "${script_dir}/../.env" ]; then
  set -a; . "${script_dir}/../.env"; set +a
fi

usage () {
  code="${1:-1}"
  printf "Usage: %s [--venv-dir VENV_DIR] [--port PORT] [MKDOCS_OPTIONS]\n" "$0"
  printf "\t--venv-dir VENV_DIR  Specify the virtual environment directory\n"
  printf "\t--port PORT          Specify the port to use (default: %d)\n" "${PORT}"
  printf "\tMKDOCS_OPTIONS       Additional options to pass to 'mkdocs serve'\n"
  printf "\n\tExample: %s --venv-dir .venv-docker --port 8000 --open\n" "$0"
  exit $code
}

use_venv () {
  local venv_dir="$1"
  if [ -n "${venv_dir}" ] ; then
    python -m venv "${venv_dir}"
    . "${venv_dir}/bin/activate"
  fi
}

install () {
  pip install --root-user-action=ignore --no-cache-dir -r mkdocs/requirements.txt
}

run_serve () {
  (set -x; mkdocs serve -f mkdocs/mkdocs.yml --dev-addr="0.0.0.0:${PORT}" --livereload "$@")
}

run_build () {
  (set -x; mkdocs build -f mkdocs/mkdocs.yml "$@")
}

init() {
  git config --system --add safe.directory /root/mkdocs/dist
}

serve () {
  while [ $# -gt 0 ]; do
    option="$1"; shift
    case "$option" in
      -d|--venv-dir)
        use_venv "$1"; shift
        ;;
      -p|--port)
        port="$1"; shift
        ;;
      -h|--help)
        usage 0
        ;;
      *)
        printf "Additional option: %s\n" "$@"
        break
        ;;
    esac
  done

  install
  run_serve "$@"
}

build () {
  while [ $# -gt 0 ]; do
    option="$1"; shift
    case "$option" in
      -d|--venv-dir)
        use_venv "$1"; shift
        ;;
      -h|--help)
        usage 0
        ;;
      *)
        printf "Additional option: %s\n" "$@"
        break
        ;;
    esac
  done

  install
  run_build "$@"
}

main () {
  init
  if [ $# -eq 0 ] ; then
    usage
    return $?
  fi
  while [ $# -gt 0 ]; do
    option="$1"; shift
    case "$option" in
      serve)
        serve "$@"
        ;;
      build)
        build "$@"
        ;;
      -h|--help)
        usage 0
        ;;
      *)
        printf "Unknown option: %s\n" "$1"
        usage 1
        ;;
    esac
  done
}

main "$@"
