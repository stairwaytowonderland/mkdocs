#!/bin/sh

################################################
## Standard logic (always include)
################################################

# Set error handling
set -euo pipefail

if [ -z "$0" ] ; then
  echo "Cannot determine script path"
  exit 1
fi

docker=false
script_name="$0"
__script_dir="$(cd "$(dirname "$script_name")" && pwd)"
SCRIPT_DIR="${SCRIPT_DIR:-$__script_dir}"

################################################
## Common logic (load common library)
################################################

# Load common functions and variables
. "${SCRIPT_DIR}/../lib/common.lib"

################################################
## Main logic
################################################

__working_dir="$(cd "${SCRIPT_DIR}/../.." && pwd)"
WORKING_DIR="${WORKING_DIR:-$__working_dir}"

# Change to working directory
cd "$WORKING_DIR" || {
  __err "Cannot change directory to" "$WORKING_DIR"
  exit 1
}

# Load environment variables from .env file if it exists
if [ -f "${WORKING_DIR}/mkdocs/.env" ]; then
  set -a; . "${WORKING_DIR}/mkdocs/.env"; set +a
fi

MKDOCS_CONFIG_FILE="${MKDOCS_CONFIG_FILE:-mkdocs/mkdocs.yaml}"
MKDOCS_SERVE_ADDR="${MKDOCS_SERVE_ADDR:-localhost}"
MKDOCS_SERVE_PORT="${MKDOCS_SERVE_PORT:-8000}"
MKDOCS_SITE_DIR_REL="${MKDOCS_SITE_DIR_REL:-mkdocs/dist}"

__abort() {
  __gitsafe "${WORKING_DIR}/${MKDOCS_SITE_DIR_REL}" "unset"
  return 0
}

__usage() {
  local code="${1:-1}"
  cat <<EOF
MkDocs Wrapper Script
========================
Usage: $script_name <command> [options] [-- <additional MkDocs options>]

Commands:
  --addr MKDOCS_SERVE_ADDR    Specify the address to bind to (default: ${MKDOCS_SERVE_ADDR})
  --file MKDOCS_CONFIG_FILE   Specify the MkDocs configuration file (default: ${MKDOCS_CONFIG_FILE})
  --port MKDOCS_SERVE_PORT    Specify the port to use (default: ${MKDOCS_SERVE_PORT})
  --venv-dir VENV_DIR         Specify the virtual environment directory

Additional MkDocs Options:
  --                          Indicate the end of options and pass remaining arguments to MkDocs

Options:
  -h, --help  Show this help message and exit

Examples:
  $script_name serve
  $script_name serve --venv-dir .venv-docker --port 8001
  $script_name serve --port 8001 -- --no-livereload
  $script_name build --venv-dir .venv-docker
EOF

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
  __message "Installing dependencies ..."
  echo $WORKING_DIR
  (set -x; pip install --root-user-action=ignore --no-cache-dir -r mkdocs/requirements.txt)
}

__run_serve() {
  echo
  __message "SERVE" "Starting \`mkdocs serve\` ..."
  test $# -eq 0 || __message "SERVE" "  additional option(s):" "$@"
  (set -x; exec mkdocs serve -f "${MKDOCS_CONFIG_FILE}" --dev-addr="${MKDOCS_SERVE_ADDR}:${MKDOCS_SERVE_PORT}" --livereload "$@")
}

__run_build() {
  echo
  __message "BUILD" "Running \`mkdocs build ...\`"
  (set -x; exec mkdocs build -f "${MKDOCS_CONFIG_FILE}" "$@")
}

__init() {
  echo
  __message "INIT" "Initializing git safe directory ..."
  __gitsafe "${WORKING_DIR}/${MKDOCS_SITE_DIR_REL}"
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
