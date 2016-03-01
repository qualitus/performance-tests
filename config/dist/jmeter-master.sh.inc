#!/bin/bash

# Configuration of the ILIAS Performance Testsuite
#
# Additional variables to run jmeter as master (aka client)

WORK_DIR=$(pwd)

OUT_DIR="${WORK_DIR}/out"

# Each of these KEY=VALUE pairs will be passed to jMeter
# via `--jmeterproperty KEY=VALUE`
JMETER_PROPERTIES+=(
  "remote_hosts=127.0.0.1:24000" # comma separated list of host[:port] (the port defaults to 1099)
  "client.rmi.localport=25001"
)

# Each of these KEY=VALUE pairs will be passed to jMeter
# via `--systemproperty KEY=VALUE`
SYSTEM_PROPERTIES+=(
  "java.rmi.server.hostname=127.0.0.1" # set this to localhost, if you want to use port-forwarding via ssh
)
