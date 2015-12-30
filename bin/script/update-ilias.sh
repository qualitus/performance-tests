#!/bin/bash

# Update ILIAS
#
# You need to install the ILIAS auto_update script first.

ENABLED=true

WORK_DIR="/opt/ilias/auto_update"
CONFIG="/etc/opt/ilias/auto_upate/trunk_config.pl"

if $ENABLED; then
  if [[ -f $CONFIG && -n $CONFIG ]]; then
    echo "Auto-Updating ILIAS [$0]"
    (cd ${WORK_DIR} && exec ./keepIliasUpToDate.pl ${CONFIG}); exit
  else
    echo -e "ERROR: Invalid configuration [$0]\n\tPlease edit this script - the CONFIG variable must point to an update configuration file."
    exit 1
  fi
else
  echo "Skipping Auto-Update (disabled) [$0]"
fi
