#!/bin/bash

# Variables from environement
: "${LOG_LEVEL:=info}"
: "${OPTIONS:=}"

# Salt master also start minion in background
echo "INFO: Starting salt-minion and auto connect to salt-master"
service salt-minion start

# start salt-api
/etc/init.d/salt-api start

# Start salt-master
echo "INFO: Starting salt-master with log level $LOG_LEVEL with hostname master"
/usr/bin/salt-master --log-level=$LOG_LEVEL $OPTIONS
