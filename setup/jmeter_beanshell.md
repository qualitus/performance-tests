# Setup Beanshell for jMeter

jMeter ignores the CLASSPATH environment variable, therefore we must install or download inside the standard search path of jMeter - even if beanshell is already installed on your system. Afterwards, we must restart jMeter.

## Option 1 - symbolic link
```bash
BEANSHELL="/usr/share/java/bsh.jar" # `locate bsh.jar`
JMETER_EXTENSIONS="/usr/share/jmeter/lib/ext" # `locate -r jmeter/lib/ext$`
sudo ln -s $BEANSHELL "${JMETER_EXTENSIONS}/bsh.jar"
```

## Option 2 - download
```bash
JMETER_EXTENSIONS="/usr/share/jmeter/lib/ext" # `locate -r jmeter/lib/ext$`
sudo wget http://www.beanshell.org/bsh-2.0b4.jar -O "{JMETER_EXTENSIONS}/lib/ext/bsh.jar"
```
