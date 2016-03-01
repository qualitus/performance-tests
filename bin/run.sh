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
  source config/jmeter-master.sh.inc || exit
}

function main {
  load_config $@

  if find "${OUT_DIR}" -mindepth 1 -print -quit | grep -q .; then
       echo "WARNING: Directory ${OUT_DIR} is not empty. You may want to run this combination instead: 'bin/script/clear_out.sh && bin/run.sh'. Press CTRL-C to abort."
       sleep 3
  fi

  echo "#### running (${TESTPLAN} in working directory: ${WORK_DIR}):"
  watch_log PID

  $JMETER_CMD \
    --nongui \
    --logfile $RESULTS \
    --testfile $TESTPLAN \
    --jmeterlogfile $LOG \
    --addprop $PROPFILE \
	  $(parse_jmeterprops ${JMETER_PROPERTIES[*]}) \
	  $(parse_systemprops ${SYSTEM_PROPERTIES[*]}) \
    $@

  EXIT=$?

  kill $PID

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

  echo "Content of ${OUT_DIR}:"
  ls -hAl "${OUT_DIR}"

  echo "To generate an HTML report, run 'bin/script/report.sh'"

  exit $EXIT
}

function parse_jmeterprops {
  for P in $@; do
    echo "--jmeterproperty ${P}"
  done
}

function parse_systemprops {
  for P in $@; do
    echo "--systemproperty ${P}"
  done
}

function watch_log {
  # runs tail in the background and returns the process id in \$$1
  # NOTE: caller is responsible to kill \$$1 afterwards - except for SIGING/TERM
  tail -n0 -F $LOG & eval $1=\$!
  trap "echo INT; kill ${!1}; exit 130" SIGINT SIGTERM # make ctrl-c etc. work
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

(cd "$(base_dir)/../" && main $@)
