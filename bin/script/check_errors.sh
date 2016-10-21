#!/bin/bash

# Run jMeter in CLI / non-GUI mode
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

  EXIT=0

  if [ "$ILIAS_PERF_REPORT_TYPE" == "xml" ]; then
    echo "Result format is XML"
    MATCH=$( grep -P "[\d\:\/ ]+ ERROR" ${LOG} )
    if [ -n "$MATCH" ]; then
      echo -e "\n**ERROR** (in ${LOG})"
      echo "$MATCH"
      EXIT=1
    fi

    MATCH=$( grep -P "^\s+\<failure\>true\<\/failure\>|\
^\s+\<error\>true\<\/error\>|\
^\s+\<failureMessage\>.*" $RESULTS )
    if [ -n "$MATCH" ]; then
      echo -e "\n**ERROR** (in $RESULTS)"
      echo "$MATCH"
      EXIT=1
    fi

    if [ $EXIT -eq 0 ]; then
      echo "No Error :-)"
    fi
  elif [ "$ILIAS_PERF_REPORT_TYPE" == "csv" ]; then
    echo "Result format is CSV"
    echo "UNIMPLEMENTED: No CSV error check implemented!"
  fi

  exit $EXIT
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
