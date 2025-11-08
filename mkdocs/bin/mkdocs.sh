#!/bin/sh

# Set error handling
set -euo pipefail

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

# Load environment variables from .env file if it exists
if [ -f "${script_dir}/../.env" ]; then
  set -a; . "${script_dir}/../.env"; set +a
fi

# Handle Ctrl + C gracefully
trap __ctrl_c INT

__message() {
  label=""
  if [ $# -gt 1 ] ; then
    label=" $1"; shift
  fi
  printf "[%s]\033[1m%s\033[0m %s\n" "$(date +'%Y-%m-%d %H:%M:%S')" "$label" "$(echo $@)"
}

__err() {
  prefix="ERROR"
  label=""
  if [ $# -gt 1 ] ; then
    label=" ${1%:}:"; shift
  fi
  printf "[%s] \033[91;1m%s\033[0m\033[91m%s\033[0m \033[91m%s\033[0m\n" "$(date +'%Y-%m-%d %H:%M:%S')" "$prefix" "$label" "$(echo $@)"
}

__ctrl_c () {
  code="$?"
  __err "\`Ctrl + C\` happened ..."
  test $code -gt 1 || code=0
  if [ $code -eq 0 ] ; then
    __message "Shutting down gracefully ..."
  else
    __message "Exiting with error code" "$code ..."
  fi
  exit $code
}

################################################
## Main functions
################################################

# Change to home directory
cd "${HOME:-/root}" || {
  __err "Cannot change directory to" "${HOME:-/root}"
  exit 1
}

PORT="${PORT:-8000}"

__usage() {
  code="${1:-$?}"
  printf "Usage: %s [--venv-dir VENV_DIR] [--port PORT] [MKDOCS_OPTIONS]\n" "$0"
  printf "\t--venv-dir VENV_DIR  Specify the virtual environment directory\n"
  printf "\t--port PORT          Specify the port to use (default: %d)\n" "${PORT}"
  printf "\tMKDOCS_OPTIONS       Additional options to pass to 'mkdocs serve' or 'mkdocs build'\n"
  printf "\n\tExample: %s %s --venv-dir .venv-docker --port 8000 --open\n" "$0" "serve"
  exit $code
}

__use_venv() {
  local venv_dir="$1"
  if [ -n "${venv_dir}" ] ; then
    python -m venv "${venv_dir}"
    . "${venv_dir}/bin/activate"
  fi
}

__install() {
  echo
  __message "Installing dependencies ..." ""
  (set -x; pip install --root-user-action=ignore --no-cache-dir -r mkdocs/requirements.txt)
}

__run_serve() {
  echo
  __message "Starting \`mkdocs serve ...\`" ""
  # if [ $# -gt 0 ] ; then
  #   __message "Starting \`mkdocs serve ...\` with additional options:" "$@"
  # else
  #   __message "Starting \`mkdocs serve ...\`" ""
  # fi
  if [ $# -gt 0 ] ; then
    __message "  additional option(s):" "$@"
  fi
  (set -x; exec mkdocs serve -f mkdocs/mkdocs.yaml --dev-addr="0.0.0.0:${PORT}" --livereload "$@")
}

__run_build() {
  echo
  __message "Running \`mkdocs build ...\`" ""
  (set -x; exec mkdocs build -f mkdocs/mkdocs.yaml "$@")
}

__init() {
  echo
  __message "Initializing git safe directory ..." ""
  (set -x; git config --system --add safe.directory /root/mkdocs/dist)
}

serve() {
  __init
  while [ $# -gt 0 ]; do
    case "$1" in
      -d|--venv-dir)
        __use_venv "$2"; shift 2
        ;;
      -p|--port)
        PORT="$2"; shift 2
        ;;
      -h|--help)
        __usage 0
        ;;
      *)
        echo
        __message "Additional option(s):" "$@"
        break
        ;;
    esac
  done

  __install
  __run_serve "$@"
}

build() {
  __init
  while [ $# -gt 0 ]; do
    case "$1" in
      -d|--venv-dir)
        __use_venv "$2"; shift 2
        ;;
      -h|--help)
        __usage 0
        ;;
      *)
        echo
        __message "Additional option(s):" "$@"
        break
        ;;
    esac
  done

  __install
  __run_build "$@"
}

main() {
  if [ $# -eq 0 ] ; then
    __usage 1
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
        __usage 0
        ;;
      *)
        echo
        __message "Unknown option:" "$option"
        __usage 1
        ;;
    esac
  done
}

main "$@"
