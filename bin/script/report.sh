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

  echo -e "\n## Generate Report (${WORK_DIR})"

  # OPTIONAL STEPS:
  # render some graphs etc.
  if [ "$ILIAS_PERF_REPORT_TYPE" == "xml" ]]; then
    echo "Result format is XML"
    REPORT=${OUT_DIR}/xml-report.html
    echo "Generating $(basename $REPORT) ($REPORT)"
    xsltproc -o ${REPORT} bin/script/report/xml2html-detailed.xsl $RESULTS || exit
    cp bin/script/report/include/* "$(dirname "${REPORT}")"
  elif [ "$ILIAS_PERF_REPORT_TYPE" == "csv" ]; then
    echo "Result format is CSV"
    echo "UNIMPLEMENTED: No CSV report parser implemented!"
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

(cd "$(base_dir)/../../" && main $@)
