#!/bin/bash

function load_config {
  WORK_DIR=$(pwd)
  OUT_DIR="${WORK_DIR}/out"
  LOADER="${WORK_DIR}/bin/extension/loader.bsh"

  RESULTS="${OUT_DIR}/results.jtl"
  LOG="${OUT_DIR}/jmeter.log"
  ILIAS_UPDATE_CMD="${WORK_DIR}/bin/extension/update-ilias.sh" \
  ILIAS_UPDATE_STDOUT="${OUT_DIR}/ilias-update_stdout.log" \
  ILIAS_UPDATE_STDERR="${OUT_DIR}/ilias-update_stderr.log" \

  # TODO: interpret bash parameters
  TESTPLAN="testcases/.staging/shell_commands.jmx"
}

function main {
  load_config $@
  reset results $RESULTS
  reset ilias_update_stdout $ILIAS_UPDATE_STDOUT
  reset ilias_update_stderr $ILIAS_UPDATE_STDERR
  echo "In Working Directory: ${WORK_DIR}"

  echo -e "\n#### running (${TESTPLAN}):"
  jmeter \
    --nongui \
    --logfile $RESULTS \
    --testfile $TESTPLAN \
    --jmeterlogfile $LOG \
	  --jmeterproperty WORK_DIR=$WORK_DIR \
    --jmeterproperty OUT_DIR=$OUT_DIR \
    --jmeterproperty LOADER=$LOADER \
    --jmeterproperty ILIAS_UPDATE_CMD=$ILIAS_UPDATE_CMD \
    --jmeterproperty ILIAS_UPDATE_STDOUT=$ILIAS_UPDATE_STDOUT \
    --jmeterproperty ILIAS_UPDATE_STDERR=$ILIAS_UPDATE_STDERR \
    $@

    # Legend:
    #--nongui \
	  #   run JMeter in nongui mode
    #--logfile <argument> \
		# 	the file to log samples to
    #--testfile <argument> \
		# 	the jmeter test(.jmx) file to run
    #--jmeterlogfile <argument> \
		# 	jmeter run log file (jmeter.log)
	  #--propfile <argument> \
		# 	the jmeter property file to use
	  #--addprop <argument> \
		# 	additional JMeter property file(s)
	  #--server \
		# 	run the JMeter server
	  #--proxyHost <argument> \
		# 	Set a proxy server for JMeter to use
	  #--proxyPort <argument> \
		# 	Set proxy server port for JMeter to use
	  #--nonProxyHosts <argument> \
		# 	Set nonproxy host list (e.g. *.apache.org|localhost)
	  #--username <argument> \
		# 	Set username for proxy server that JMeter is to use
	  #--password <argument> \
		# 	Set password for proxy server that JMeter is to use
	  #--jmeterproperty <argument>=<value> \
		# 	Define additional JMeter properties
	  #--globalproperty <argument>=<value> \
		# 	Define Global properties (sent to servers)
	 	#    e.g. -Gport=123 or -Gglobal.properties
	  #--systemproperty <argument>=<value> \
		# 	Define additional system properties
	  #--systemPropertyFile <argument> \
		# 	additional system property file(s)
	  #--loglevel <argument>=<value> \
		# 	[category=]level e.g. jorphan=INFO or jmeter.util=DEBUG
	  #--runremote \
		# 	Start remote servers (as defined in remote_hosts)
	  #--remotestart <argument> \
		# 	Start these remote servers (overrides remote_hosts)
	  #--homedir <argument> \
		# 	the jmeter home directory to use
	  #--remoteexit \
		# 	Exit the remote servers at end of test (non-GUI)

  show results $RESULTS
  show log $LOG
  show ilias_update_stdout $ILIAS_UPDATE_STDOUT
  show ilias_update_stderr $ILIAS_UPDATE_STDERR
}

function reset {
  echo -e "Resetting ${1} (${2})"
  printf "" > $2
}

function show {
  echo -e "\n#### ${1} (${2}):"
  cat $2
}

function base_dir {
  # get the directory one level higher than this script
  # derived from http://stackoverflow.com/questions/59895
  local __SOURCE="${BASH_SOURCE[0]}"
  while [ -h "$__SOURCE" ]; do # resolve $__SOURCE until the file is no longer a symlink
    local __DIR="$( cd -P "$( dirname "$__SOURCE" )" && pwd )"
    local __SOURCE="$(readlink "$__SOURCE")"
    [[ $__SOURCE != /* ]] && SOURCE="$__DIR/$__SOURCE" # if $__SOURCE was a relative symlink, we need to resolve it relative to the path where the symlink file was located
  done
  local __DIR="$( cd -P "$( dirname "$__SOURCE" )" && pwd )"
  echo "${__DIR}/../"
}

(cd $(base_dir) && main $@)
