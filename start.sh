#!/bin/bash
read -p "Please enter desired cron frequency (Note: the format should be similar to '*/5 * * * *' to run every 5 minutes): " CRON_FREQ
read -p "Please enter the command to watch: " WATCH_COMMAND
read -p "Please enter the grep parameter: " GREP_PARAM
read -p "Please enter your healthcheck.io id: " HEALTHCHECK_ID

GITHUB_URL='https://raw.githubusercontent.com/subscan-explorer/watch-logs-script/master/validator-watch.sh'
SCRIPT_FILE='validator-watch.sh'

if [ ! -f $SCRIPT_FILE ]; then
    echo "$SCRIPT_FILE does not exist. Downloading from GitHub..."
    curl --silent --location --remote-name $GITHUB_URL
    chmod +x $SCRIPT_FILE
else
    echo "$SCRIPT_FILE already exists. No need to download."
fi

JOB="$CRON_FREQ $PWD/$SCRIPT_FILE \"$WATCH_COMMAND\" \"$GREP_PARAM\" \"$HEALTHCHECK_ID\""

(crontab -l 2>/dev/null; echo "$JOB") | crontab -

echo "Cron job added. The current crontab is:"
crontab -l
