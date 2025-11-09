#!/bin/sh

# Set error handling
set -euo pipefail

################################################
## Common functions
################################################

# Ensure the script is running inside a Docker container
# test -f /.dockerenv || {
#   echo "This script is intended to be run inside a Docker container."
#   exit 1
# }

if [ -z "$0" ] ; then
  echo "Cannot determine script path"
  exit 1
fi

__script_dir="$(cd "$(dirname "$0")" && pwd)"
SCRIPT_DIR="${SCRIPT_DIR:-$__script_dir}"
__working_dir="$(cd "${SCRIPT_DIR}/../.." && pwd)"
WORKING_DIR="${WORKING_DIR:-$__working_dir}"

# Load environment variables from .env file if it exists
if [ -f "${WORKING_DIR}/mkdocs/.env" ]; then
  set -a; . "${WORKING_DIR}/mkdocs/.env"; set +a
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
  __abort
  exit $code
}

################################################
## Main functions
################################################

# Change to working directory
cd "$WORKING_DIR" || {
  __err "Cannot change directory to" "$WORKING_DIR"
  exit 1
}

MKDOCS_CONFIG_FILE="${MKDOCS_CONFIG_FILE:-mkdocs/mkdocs.yaml}"
MKDOCS_SERVE_ADDR="${MKDOCS_SERVE_ADDR:-localhost}"
MKDOCS_SERVE_PORT="${MKDOCS_SERVE_PORT:-8000}"
MKDOCS_SITE_DIR_REL="${MKDOCS_SITE_DIR_REL:-mkdocs/dist}"

__abort() {
  (set -x; git config --global --unset safe.directory "${WORKING_DIR}/${MKDOCS_SITE_DIR_REL}" || true)
  return 0
}

__usage() {
  local code="${1:-1}"
  printf "Usage: %s \
[--addr MKDOCS_SERVE_ADDR] \
[--file MKDOCS_CONFIG_FILE] \
[--port MKDOCS_SERVE_PORT] \
[--venv-dir VENV_DIR] \
[MKDOCS_OPTIONS]\n" \
"$0"
  printf "\t--addr MKDOCS_SERVE_ADDR    Specify the address to bind to (default: %s)\n" "${MKDOCS_SERVE_ADDR}"
  printf "\t--file MKDOCS_CONFIG_FILE   Specify the MkDocs configuration file (default: %s)\n" "${MKDOCS_CONFIG_FILE}"
  printf "\t--port MKDOCS_SERVE_PORT    Specify the port to use (default: %d)\n" "${MKDOCS_SERVE_PORT}"
  printf "\t--venv-dir VENV_DIR  Specify the virtual environment directory\n"
  printf "\tMKDOCS_OPTIONS              Additional options to pass to 'mkdocs serve' or 'mkdocs build'\n"
  printf "\n\tExample: %s %s --venv-dir .venv-docker --port 8000\n" "$0" "serve"
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
  echo $WORKING_DIR
  (set -x; pip install --root-user-action=ignore --no-cache-dir -r mkdocs/requirements.txt)
}

__run_serve() {
  echo
  __message "SERVE" "Starting \`mkdocs serve ...\`" ""
  # if [ $# -gt 0 ] ; then
  #   __message "Starting \`mkdocs serve ...\` with additional options:" "$@"
  # else
  #   __message "Starting \`mkdocs serve ...\`" ""
  # fi
  test $# -eq 0 || __message "SERVE" "  additional option(s):" "$@"
  (set -x; exec mkdocs serve -f "${MKDOCS_CONFIG_FILE}" --dev-addr="${MKDOCS_SERVE_ADDR}:${MKDOCS_SERVE_PORT}" --livereload "$@")
}

__run_build() {
  echo
  __message "BUILD" "Running \`mkdocs build ...\`" ""
  (set -x; exec mkdocs build -f "${MKDOCS_CONFIG_FILE}" "$@")
}

__init() {
  echo
  __message "INIT" "Initializing git safe directory ..." ""
  (set -x; git config --global --add safe.directory "${WORKING_DIR}/${MKDOCS_SITE_DIR_REL}")
}

serve() {
  __init
  while [ $# -gt 0 ]; do
    case "$1" in
      -a|--addr)
        MKDOCS_SERVE_ADDR="$2"
        shift 2
        ;;
      -d|--venv-dir)
        __use_venv "$2"
        shift 2
        ;;
      -f|--file)
        MKDOCS_CONFIG_FILE="$2"
        shift 2
        ;;
      -h|--help)
        __usage 0
        ;;
      -p|--port)
        MKDOCS_SERVE_PORT="$2"
        shift 2
        ;;
      --)
        shift
        __message "Additional option(s):" "$@"
        break
        ;;
      *)
        echo
        __err "Unknown option:" "$1"
        __usage
        shift
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
        __use_venv "$2"
        shift 2
        ;;
      -f|--file)
        MKDOCS_CONFIG_FILE="$2"
        shift 2
        ;;
      -h|--help)
        __usage 0
        ;;
      --)
        shift
        __message "Additional option(s):" "$@"
        break
        ;;
      *)
        echo
        __err "Unknown option:" "$1"
        __usage
        shift
        ;;
    esac
  done

  __install
  __run_build "$@"
}

main() {
  test $# -gt 0 || __usage
  while [ $# -gt 0 ]; do
    option="$1"; shift
    case "$option" in
      serve)
        serve "$@"
        break
        ;;
      build)
        build "$@"
        break
        ;;
      -h|--help)
        __usage 0
        ;;
      *)
        echo
        __err "Unknown option:" "$option"
        __usage
        break
        ;;
    esac
  done
}

main "$@"
