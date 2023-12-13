## Validator Watch Script

This repository contains a script designed to execute a user-designed command, filter its output, and notify healthcheck.io with the results. The scripts in this repository are:

* start.sh: An initialization script to setup cron job for the validator_watch.sh.
* validator_watch.sh: A script designed to execute a user-design command, filter its output with grep and notify healthcheck.io if new logs appear.

### Usage

#### start.sh
This script sets up a cron job to execute the validator_watch.sh regularly. Run it with the following steps:
* In terminal, navigate to the directory containing start.sh.
* Run the script: ./start.sh.
* The script will ask for your cron frequency, the command to watch, the grep parameter, and your healthcheck.io id.
#### validator_watch.sh
This script is designed to execute a user-specified command, filter its output with grep, and notify healthcheck.io if new logs appear. It is generally meant to be used with a cron job set by the start.sh, and you don't have to run it manually. However, if you want to use it standalone, you can do so as follows:
* Execute the script with: ./validator_watch.sh "<command>" "<grep_parameter>" "<healthcheck_io_id>".
