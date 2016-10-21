#!/bin/bash

# Save this file as 'config/ilias/reset_client.sh.inc'
#
# path of executable: 'bin/script/ilias/reset_client.sh'

BACKUP_BASEDIR=""; # './backup/' path for backups
DATA_DIR_INTERN_SOURCE=""; # '/srv/www/ILIAS/template/data'
DATA_DIR_INTERN_TARGET=""; # '/srv/www/ILIAS/tmp/data'
DATA_DIR_EXTERN_SOURCE=""; # '/srv/www/ILIAS/data/template'
DATA_DIR_EXTERN_TARGET=""; # '/srv/www/ILIAS/data/tmp';
DB_DATABASE_SOURCE=""; # 'ilias_template';
DB_DATABASE_TARGET=""; # 'ilias_tmp';
DB_HOST=""; # Optional: 'localhost' Database Host
DB_PORT=""; # Optional: '3306' Database Port
DB_USER=""; # Optional: Database User
DB_PASSWORD=""; # Optional: Database Password
