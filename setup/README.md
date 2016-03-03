# Instructions

## Single jMeter Instance + ILIAS (Default)

We need to install and setup the following packages.

* `git clone https://github.com/qualitus/performance-tests.git`
  * list all tags: `git tag -l`
  * and then checkout the latest version by its tag: `git checkout tags/<tag_name>`
  * alternatively you can download the [latest release](https://github.com/qualitus/performance-tests/releases/latest) as a ZIP file. Unzip it in a directory of your choice.
* install **jMeter 2.13**
  * run this in the project root `curl http://mirror.netcologne.de/apache.org/jmeter/binaries/apache-jmeter-2.13.tgz | tar xvz`
  * Or, you can always find the latest binary at the [official download page](http://jmeter.apache.org/download_jmeter.cgi)
  * _Alternatively_ install jMeter with the package manager of your distribution,
    but make sure it matches the version necessary for this testsuite.
* install xsltproc (for xml-based reports): `sudo apt-get install xsltproc`
* testsuite configuration
  * `cp -r config/dist/* config/`
  * adjust the main configuration file `jmeter.sh.inc`.
    Make sure it points to
    your executable of jMeter and your ILIAS installation.
    You may want to come back to this configuration later, to adjust the number
    of threads and loops (concurrency and repetition).
* ilias configuration `setup/ilias_configuration.md`
* ilias users for testsuite: `setup/jmeter_ilias_users.md`

#### Optional
* link binary: `sudo ln -s $(pwd)/bin/jmeter.sh /usr/bin/jmeter-ilias`
* add desktop shortcut: `sudo cp setup/var/jmeter-ilias.desktop /usr/share/applications/`

## Distributed Testing (Alternative)

Note that this guide does not yet deal with all of the details like port-configuration.

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
