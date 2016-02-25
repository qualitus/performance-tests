# Instructions

We need to install and setup the following packages. This section is split into two parts, according to the master-slave setup.

## Local Tests

* install jMeter
* xsltproc (for xml-based reports): `sudo apt-get install xsltproc`
* ilias configuration `setup/ilias_configuration.md`
* ilias users for testsuite: `setup/jmeter_ilias_users.md`

Optional:
* link binary: `sudo ln -s $(pwd)/bin/jmeter.sh /usr/bin/jmeter-ilias`
* add desktop shortcut: `sudo cp setup/var/jmeter-ilias.desktop /usr/share/applications/`

## Distributed Testing

### Master Server

* install jMeter
* TeamCity (or other CI-Server)
* xsltproc (for xml-based reports): `sudo apt-get install xsltproc`

### Slave Server + ILIAS

* install jMeter
* ilias auto_update script: `setup/bin/install_ilias_auto_update.sh`
* ilias configuration `setup/ilias_configuration.md`
* ilias users for testsuite: `setup/jmeter_ilias_users.md`

Optional:
* ilias auto_update script (use at own risk): `setup/bin/install_ilias_auto_update.sh`
