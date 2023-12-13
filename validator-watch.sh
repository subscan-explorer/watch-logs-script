info() {
    echo -e "`date '+%Y-%m-%d %H:%M:%S'` [info] $1"
}

error() {
    echo -e "`date '+%Y-%m-%d %H:%M:%S'` [error] $1"
}

if ! command -v curl &> /dev/null; then
    error "Curl could not be found. Please install curl and retry."
    exit 1
fi

if [ $# -ne 3 ]; then
    error "Usage: $0 <command> <grep_param> <healthcheck_io_id>"
    exit 1
fi

if [ -z "$1" ] || [ -z "$2" ] || [ -z "$3" ]; then
    error "None of the arguments should be empty."
    exit 1
fi

info "Starting validator watch script."

COMMAND="$1"
GREP_PARM="$2"
HEALTHCHECK_HOST="hc-ping.com"
HEALTHCHECK_IO_ID="$3"

logs=$($COMMAND 2>&1 | grep "$GREP_PARM")
if [ -z "$logs" ]; then
    error "No logs detected. Notifying healthchecks.io."
    curl -fsS -m 10 --retry 5 -o /dev/null https://"$HEALTHCHECK_HOST"/"$HEALTHCHECK_IO_ID"/fail || error "Failed to notify healthchecks.io"
    exit 0
fi

info "New logs detected. Notifying healthchecks.io."
curl -fsS -m 10 --retry 5 -o /dev/null --data-raw "$logs" https://"$HEALTHCHECK_HOST"/"$HEALTHCHECK_IO_ID" || error "Failed to notify healthchecks.io"
