# Instructions

## Single jMeter Instance + ILIAS (Default)

We need to install and setup the following packages.

* `git clone https://github.com/qualitus/performance-tests.git`
* install jMeter 2.13 -> [download latest stand-alone binaries](http://jmeter.apache.org/download_jmeter.cgi)
* xsltproc (for xml-based reports): `sudo apt-get install xsltproc`

Configuration

* ilias configuration `setup/ilias_configuration.md`
* ilias users for testsuite: `setup/jmeter_ilias_users.md`

Optional:
* link binary: `sudo ln -s $(pwd)/bin/jmeter.sh /usr/bin/jmeter-ilias`
* add desktop shortcut: `sudo cp setup/var/jmeter-ilias.desktop /usr/share/applications/`

## Distributed Testing (Alternative)

Note that this guide does not yet deal with all of the details like port-configuration.

A master-slave-setup for distributed testing can be setup as follows.

### Master Server

* `git clone https://github.com/qualitus/performance-tests.git`
* install jMeter as above
* TeamCity (or other CI-Server)
* xsltproc (for xml-based reports): `sudo apt-get install xsltproc`

### Slave Server

* `git clone https://github.com/qualitus/performance-tests.git`
* install jMeter as above
* ilias users for testsuite: `setup/jmeter_ilias_users.md`

### ILIAS

* ilias configuration `setup/ilias_configuration.md`

Optional:
* ilias auto_update script (use at own risk): `setup/bin/install_ilias_auto_update.sh`
