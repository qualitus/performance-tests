# Instructions for advanced setups

The following instructions are only required for advanced usage. You find an easy **Quick-Start** guide in the README.md at the top-level of this testsuite, which should be sufficient for most cases.

The testsuite can be used on a single jMeter instance, or for distributed testing.

## Single jMeter Instance + ILIAS (Default)

A single jMeter instance can be setup with this testsuite as follows.

* `git clone https://github.com/qualitus/performance-tests.git`
  * either checkout the master branch `git checkout master`
  * or checkout a specific release
    * list all tags: `git tag -l`
    * and then checkout the latest version by its tag: `git checkout tags/<tag_name>`
  * alternatively you can download the [latest release](https://github.com/qualitus/performance-tests/releases/latest) as a ZIP file. Unzip it in a directory of your choice.
* install **jMeter 2.13**
  * run this in the project root (the testsuite directory)  `curl http://mirror.netcologne.de/apache.org/jmeter/binaries/apache-jmeter-2.13.tgz | tar xvz`
  * Or, you can always find the latest binary at the [official download page](http://jmeter.apache.org/download_jmeter.cgi)
  * _Alternatively_ install jMeter with the package manager of your distribution,
    but make sure it matches the version necessary for this testsuite.
* for xml-based reports, install xsltproc: `sudo apt-get install xsltproc`
* testsuite configuration
  * If you use the master branch or any stable release, you will find the configuration files in the `config` directory.
  * If you want to reset your configuration, or if you are using the develop-branch you have to `cp -r config/dist/* config/`.
  * adjust the main configuration file `jmeter.sh.inc`.
    Make sure it points to
    your executable of jMeter and your ILIAS installation.
    You may want to come back to this configuration later, to adjust the number
    of threads and loops (concurrency and repetition).
* ilias configuration `setup/ilias_configuration.md`
* ilias users for testsuite: `setup/jmeter_ilias_users.md`

#### Optional
* link the binary, so you can call it from any directory: `sudo ln -s $(pwd)/bin/jmeter.sh /usr/bin/jmeter-ilias`
* add a desktop shortcut: `sudo cp setup/var/jmeter-ilias.desktop /usr/share/applications/`

## Distributed Testing (Alternative)

Note that this guide does not yet deal with all of the details like port-configuration. Please use the ticket tracker, if you have any questions.

A master-slave-setup for distributed testing can be setup as follows.

### Master Server

* `git clone https://github.com/qualitus/performance-tests.git`
* install jMeter as above
* xsltproc (for xml-based reports): `sudo apt-get install xsltproc`
* testsuite configuration as above - additionally edit `config/jmeter-master.sh.inc`

#### Optional

* TeamCity (or other CI-Server)

### Slave Server

* `git clone https://github.com/qualitus/performance-tests.git`
* install jMeter as above
* edit `config/jmeter-slave.sh.inc`
* ilias users for testsuite: `setup/jmeter_ilias_users.md`

### ILIAS

* ilias configuration `setup/ilias_configuration.md`

#### Optional

* ilias auto_update script (use at own risk): `setup/bin/install_ilias_auto_update.sh`
