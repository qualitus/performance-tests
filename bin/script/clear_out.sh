#!/bin/bash

# Clear ${OUT_DIR}
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

  if [ -e ${OUT_DIR} ]; then
    echo "Clear $(basename $OUT_DIR) ($OUT_DIR)"
    ls -l ${OUT_DIR}

    echo -e "\nWARNING: Above files will be deleted"
    confirm

    rm -r ${OUT_DIR}
  else
    echo "Directory will be created: $(basename $OUT_DIR) ($OUT_DIR)"
  fi

  mkdir ${OUT_DIR}
}

confirm() {
  read -rp 'Enter "y" to confirm...' REPLY
  if [[ ! $REPLY =~ ^[Yy]$ ]]; then
    exit 1
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
