#!/bin/bash

# Invoked by ILIAS Performance Testsuite before each testrun
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

  replace_script_out
  echo -e "\n## Begin Startup (${WORK_DIR})"

  # OPTIONAL STEPS:
  # ${WORK_DIR}/bin/script/update-ilias.sh

  echo "## End Startup"
}

function replace_script_out {
  exec 1> >(tee $SCRIPT_STDOUT) 2> >(tee $SCRIPT_STDERR >&2)
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

(cd "$(base_dir)/../../" && main $@)
