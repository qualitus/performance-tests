#!/bin/bash

# Configuration of the ILIAS Performance Testsuite
#
# This is only loaded, if jmeter is run via "bin/slave.sh".

WORK_DIR=$(pwd)

OUT_DIR="${WORK_DIR}/out"

LOG="${OUT_DIR}/jmeter-server.log" # may want to add a timestamp YYYY-MM-DD...

# Each of these KEY=VALUE pairs will be passed to jMeter
# via `--jmeterproperty KEY=VALUE`
JMETER_PROPERTIES+=(
  "server.rmi.localhostname=127.0.0.1"
  "server.rmi.localport=26000"
  "jmeterproperty server_port=24000"
)

# Each of these KEY=VALUE pairs will be passed to jMeter
# via `--systemproperty KEY=VALUE`
SYSTEM_PROPERTIES+=(
  "java.rmi.server.hostname=127.0.0.1" # set this to localhost, if you want to use port-forwarding via ssh
)
