#!/bin/bash

# Configuration of the ILIAS Performance Testsuite
#
# This bash script defines local variables used by `bin/run.sh`.
# It will be included by

# TODO: interpret bash parameters $(echo $1; shift)
TESTPLAN="testcases/staging/login.jmx"

WORK_DIR=$(pwd)
OUT_DIR="${WORK_DIR}/out"
LOADER="${WORK_DIR}/bin/script/loader.bsh"

RESULTS="${OUT_DIR}/results.csv"
PROPFILE="${WORK_DIR}/config/jmeter.properties"
LOG="${OUT_DIR}/jmeter.log" # may want to add a timestamp YYYY-MM-DD...
SCRIPT_STDOUT="${OUT_DIR}/script_stdout.log"
SCRIPT_STDERR="${OUT_DIR}/script_stderr.log"

# Each of these KEY=VALUE pairs will be passed to jMeter
# via `--addproperty KEY=VALUE`
PROPERTIES=(
  "PROTOCOL=http" # http, https, file
  "HOST=localhost" # domain or ip, e.g. www.ilias.de, localhost, 127.0.0.1
  "PATH=/ilias/trunk" # must not be empty - e.g. /, /path/to/ilias, /docu, /test51, ..
  "PORT=80" # e.g. 80, 443
  "THREADS=1" # default: 1
  "RAMP_UP=1" # default: 1
  "LOOPS=1" # default: 1
  "WORK_DIR=$WORK_DIR"
  "OUT_DIR=$OUT_DIR"
  "ON_STARTUP=${WORK_DIR}/bin/script/startup.sh"
  "ON_TEARDOWN=${WORK_DIR}/bin/script/teardown.sh"
  "CREDENTIALS_CSV=$WORK_DIR/config/users.csv"
)
