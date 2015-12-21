#!/bin/bash

SOURCE="https://gist.github.com/colin-kiegel/0b2f2f7b061db7087225/raw/5497142a27bd81443d79eebfba66697e26118d9f/ilias_auto_update.tar.gz"

sudo wget $SOURCE -O /var/tmp/ilias_auto_update.tar.gz

sudo mkdir /opt/ilias
sudo mkdir /etc/opt/ilias/auto_upate -p

sudo tar -xzf /var/tmp/ilias_auto_update.tar.gz -C /opt/ilias
sudo printf '#!/bin/bash\n(cd /opt/ilias/auto_update && exec ./keepIliasUpToDate.pl $@)\n' > /opt/ilias/auto_update/run.sh
sudo chmod +x /opt/ilias/auto_update/run.sh
sudo ln -s /opt/ilias/auto_update/run.sh /usr/local/bin/update_ilias
sudo ln -s /opt/ilias/auto_update/config.pl.dist /etc/opt/ilias/auto_upate/

echo "Execute like `update_ilias /etc/opt/ilias/auto_update/YOUR_CONFIG.pl`"
echo " * A sample configuration can be found here `less /etc/opt/ilias/auto_update/config.pl.dist`"
