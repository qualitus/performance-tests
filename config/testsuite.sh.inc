#!/bin/bash

# Configuration of the ILIAS Performance Testsuite
#
# This bash script defines local variables used by `bin/run.sh`.
# It will be included by

WORK_DIR=$(pwd)

# TODO: interpret bash parameters $(echo $1; shift)
TESTPLAN="testcases/suite.jmx"

# jMeter Command -- default: jmeter
JMETER_CMD=${WORK_DIR}/.apache-jmeter-2.13/bin/jmeter.sh
OUT_DIR="${WORK_DIR}/out"
LOADER="${WORK_DIR}/bin/script/loader.bsh"

##### Save results as CSV or XML #####
# RESULTS="${OUT_DIR}/results.csv"
# PROPFILE="${WORK_DIR}/config/jmeter/csv-results.properties"
RESULTS="${OUT_DIR}/results.xml"
PROPFILE="${WORK_DIR}/config/jmeter/xml-results.properties"
#####

LOG="${OUT_DIR}/jmeter.log" # may want to add a timestamp YYYY-MM-DD...
SCRIPT_STDOUT="${OUT_DIR}/script_stdout.log"
SCRIPT_STDERR="${OUT_DIR}/script_stderr.log"

# Each of these KEY=VALUE pairs will be passed to jMeter
# via `--jmeterproperty KEY=VALUE`
JMETER_PROPERTIES=(
  "PROTOCOL=https" # http, https, file
  "HOST=sigperf.iliasnet.de" # domain or ip, e.g. www.ilias.de, localhost, 127.0.0.1
  "PATH=/" # must not be empty - e.g. /, /path/to/ilias, /docu, /test51, ..
  # "PATH=/ilias/trunk" # must not be empty - e.g. /, /path/to/ilias, /docu, /test51, ..
  "PORT=443" # e.g. 80, 443
  "CLIENT_ID=SIGPERF" # e.g. ilias
  "THREADS=1" # default: 1
  "RAMP_UP=1" # default: 1
  "LOOPS=1" # default: 1
  "WORK_DIR=$WORK_DIR"
  "OUT_DIR=$OUT_DIR"
  "ON_STARTUP=${WORK_DIR}/bin/script/startup.sh"
  "ON_TEARDOWN=${WORK_DIR}/bin/script/teardown.sh"
  "CREDENTIALS_CSV=$WORK_DIR/config/users_sigperf.csv"
  #"CREDENTIALS_CSV=/home/svnuser/performance-tests/users_sigperf.csv"
  "IS_ADMIN=true" # default: false
  "remote_hosts=127.0.0.1:24000" # comma separated list of host[:port] (the port defaults to 1099)
  "client.rmi.localport=25000"
)

# Each of these KEY=VALUE pairs will be passed to jMeter
# via `--systemproperty KEY=VALUE`
SYSTEM_PROPERTIES=(
  "java.rmi.server.hostname=127.0.0.1" # set this to localhost, if you want to use port-forwarding via ssh
)
