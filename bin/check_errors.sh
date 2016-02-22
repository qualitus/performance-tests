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

  if [[ -s ${SCRIPT_STDERR} ]]; then
    echo -e "\n**ERROR** (in ${SCRIPT_STDERR})"
    cat ${SCRIPT_STDERR}
    EXIT=1
  fi;

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

  exit $EXIT
}

function base_dir {
  # get the directory one level higher than this script in a reliable way
  # derived from http://stackoverflow.com/questions/59895
  local __SOURCE="${BASH_SOURCE[0]}"
  while [ -h "$__SOURCE" ]; do # resolve $__SOURCE until the file is no longer a symlink
    local __DIR="$( cd -P "$( dirname "$__SOURCE" )" && pwd )"
    local __SOURCE="$(readlink "$__SOURCE")"
    [[ $__SOURCE != /* ]] && SOURCE="$__DIR/$__SOURCE" # if $__SOURCE was a relative symlink, we need to resolve it relative to the path where the symlink file was located
  done
  local __DIR="$( cd -P "$( dirname "$__SOURCE" )" && pwd )"
  echo ${__DIR}
}

(cd "$(base_dir)/../" && main $@)
