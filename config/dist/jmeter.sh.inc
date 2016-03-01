#!/bin/bash

# Configuration of the ILIAS Performance Testsuite
#
# You must restart jMeter for any changes to take effect.
#
# This bash script defines local variables used by `bin/run.sh`,
# `bin\jmeter.sh`, etc.

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
  "PROTOCOL=http" # http, https, file
  "HOST=localhost" # domain or ip, e.g. www.ilias.de, localhost, 127.0.0.1
  "PATH=/ilias/trunk/" # must not be empty - e.g. /, /path/to/ilias, /docu, /test51, ..
  "PORT=80" # e.g. 80, 443
  "CLIENT_ID=ilias" # e.g. ilias
  "CREDENTIALS_CSV=$WORK_DIR/config/users.csv"
  "IS_ADMIN=true" # default: false

  "THREADS=1" # default: 1
  "RAMP_UP=1" # default: 1
  "LOOPS=1" # default: 1
  "WORK_DIR=$WORK_DIR"
  "OUT_DIR=$OUT_DIR"
  "ON_STARTUP=${WORK_DIR}/bin/script/startup.sh"
  "ON_TEARDOWN=${WORK_DIR}/bin/script/teardown.sh"
)

# Each of these KEY=VALUE pairs will be passed to jMeter
# via `--systemproperty KEY=VALUE`
SYSTEM_PROPERTIES=(
)
