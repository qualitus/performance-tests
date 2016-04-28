# Community Performance Testsuite for ILIAS

You need **Linux (or Mac)** - this will not work on Windows.

## Quick-Start

1. Download
 * [Testsuite v0.1.0][dl-testsuite-0.1.0] and unzip it in a directory of your choice.
 * [jMeter v2.13][dl-jmeter-2.13] and unzip it _inside_ the testsuite directory.
* Create an ILIAS User and test the login (accept the user agreement, etc.)
* Edit the configuration `config/jmeter.sh.inc`
* Run `bin/jmeter.sh`

More advanced instructions can be found in the  [setup](https://github.com/qualitus/performance-tests/tree/master/setup) directory.

[dl-testsuite-0.1.0]: https://github.com/qualitus/performance-tests/archive/v0.1.0.zip
[dl-jmeter-2.13]: http://mirror.23media.de/apache//jmeter/binaries/apache-jmeter-2.13.zip

## Troubleshooting

Please feel free to use the [issue tracker](https://github.com/qualitus/performance-tests/issues) of this repository,
**if you should have any question**.
It is meant to be used for any support AND bugs related to this testsuite.

## Further Information
This testsuite requires **jMeter 2.13** and is designed to run on Linux. It should also run on Mac, but not on Windows.

Further documentation about this suite can be found here [wiki](https://github.com/qualitus/performance-tests/wiki).
