The replace-client script allows you to replace one client by another one.

# Use case

If you want to repeat the same measurement under identical circumstances, you can
work with two clients. One client serves as a template and the other one serves as
a temporary instance. After each measurement the temporary instance can be replaced
with a fresh copy of the template with this script.

# Configuration

Goto the config folder of this repository and copy the configuration template to this destination

cd config
cp dist/ilias/replace_client.sh.inc ilias/replace_client.sh.inc --parents

# Execution

path of executable: 'bin/script/ilias/replace_client.sh'
