#!/bin/bash

# Configuration of the ILIAS Performance Testsuite
#
# You must restart jMeter for any changes to take effect.
#
# This bash script defines local variables used by `bin/run.sh`,
# `bin\jmeter.sh`, etc.

WORK_DIR=$(pwd) # do not change this, unless necessary

TESTPLAN="testcases/suite.jmx" # TODO: interpret bash parameters $(echo $1; shift)
JMETER_CMD=${WORK_DIR}/apache-jmeter-2.13/bin/jmeter.sh # jMeter Command -- default: jmeter, if in PATH env variable
OUT_DIR="${WORK_DIR}/out"
LOG="${OUT_DIR}/jmeter.log" # may want to add a timestamp YYYY-MM-DD...

##### Save results as CSV or XML #####
ILIAS_PERF_REPORT_TYPE="${ILIAS_PERF_REPORT_TYPE,,}"
if [ "$ILIAS_PERF_REPORT_TYPE" != "csv" ] && [ "$ILIAS_PERF_REPORT_TYPE" != "xml" ]; then
  echo "WARNING: environment variable ILIAS_PERF_REPORT_TYPE is not set. Assuming ILIAS_PERF_REPORT_TYPE=\"xml\"."
  ILIAS_PERF_REPORT_TYPE="xml"
fi
RESULTS="${OUT_DIR}/results.${ILIAS_PERF_REPORT_TYPE}"
PROPFILE="${WORK_DIR}/config/jmeter/${ILIAS_PERF_REPORT_TYPE}-results.properties"
#####

# Each of these KEY=VALUE pairs will be passed to jMeter
# via `--jmeterproperty KEY=VALUE`
JMETER_PROPERTIES=(
  "PROTOCOL=http" # http, https, file
  "HOST=localhost" # domain or ip, e.g. www.ilias.de, localhost, 127.0.0.1
  "PATH=/ilias/trunk/" # must not be empty - e.g. /, /path/to/ilias, /docu, /test51, ..
  "PORT=80" # e.g. 80, 443
  "CLIENT_ID=ilias" # e.g. ilias
  "IS_ADMIN=false" # default: false
  "READ_ONLY=true" # default: true

  # Default: Static Credentials
  "USERNAME=" # ILIAS-User
  "PASSWORD=" # ILIAS-Password

  # Alternative: Credentials from CSV
  # "CREDENTIALS_CSV=$WORK_DIR/config/users.csv" # OVERRIDE username and password with values from this CSV file

  "THREADS=1" # default: 1
  "RAMP_UP=1" # default: 1
  "LOOPS=1" # default: 1
  "WORK_DIR=$WORK_DIR"
)

# Each of these KEY=VALUE pairs will be passed to jMeter
# via `--systemproperty KEY=VALUE`
SYSTEM_PROPERTIES=(
)
