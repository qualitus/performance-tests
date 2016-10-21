#!/bin/bash

# Generate an html-report
#
# Run this after the test has completed
#
# NOTE:
# * This script `cd`s into the testsuite root directory (see very last line)
# * Be careful when moving this script around
# * If you need the *real* basedir, simply call $(basedir)

function load_config {
  # defines a bunch of shell variables - see the include for details
  source config/jmeter.sh.inc || exit
}

function main {
  load_config $@

  if [ "$ILIAS_PERF_REPORT_TYPE" == "xml" ]]; then
    echo "Result format is XML"
    REPORT=${OUT_DIR}/xml-report.html
    if [[ $RESULTS != *.xml ]]; then
      echo "ERROR: Result format is XML"
      exit 1
    fi

    REPORT=${OUT_DIR}/teamcity-info.xml
    echo "Generating $(basename $REPORT) ($REPORT)"

    xsltproc -o $REPORT bin/script/teamcity/info.xsl $RESULTS || exit
  elif [ "$ILIAS_PERF_REPORT_TYPE" == "csv" ]; then
    echo "Result format is CSV"
    echo "UNIMPLEMENTED: No CSV info parser implemented!"
  fi
}

function base_dir {
  if hash readlink 2>/dev/null; then
    # use readlink, if installed, to follow symlinks
    local __DIR="$(dirname "$(readlink -f "$0")")"
  else
    local __DIR="$(dirname "$0")"
  fi
  echo ${__DIR}
}

(cd "$(base_dir)/../../../" && main $@)
