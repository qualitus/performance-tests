# Instructions

We need to install and setup the following packages. This section is split into two parts, according to the master-slave setup.

## Master Server

* jMeter: `sudo apt-get install jmeter`
* TeamCity (or other CI-Server)

## Slave Server

* jMeter: `sudo apt-get install jmeter`
* ilias auto_update script: `setup/bin/install_ilias_auto_update.sh`
* ilias users: setup/jmeter_ilias_users.md

## Local Tests

* jMeter: `sudo apt-get install jmeter`
* ilias auto_update script: `setup/bin/install_ilias_auto_update.sh`
* ilias users: setup/jmeter_ilias_users.md
* link binary: `sudo ln -s $(pwd)/bin/jmeter.sh /usr/bin/jmeter-ilias`
* add desktop shortcut: `sudo cp jmeter-ilias.desktop /usr/share/applications/`
* xsltproc (for xml-based reports): `sudo apt-get isntall xsltproc`
* ?python (for csv-based reports)
