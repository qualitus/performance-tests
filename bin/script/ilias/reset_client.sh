#!/bin/bash

# reset one ILIAS client with another client
#
# copies data dirs and database after creating a backup
# this is useful to always start with a fresh client when doing performance tests
#
# NOTE: After repeated usage you might want to clean up backup directories

function load_config {
  # defines a bunch of shell variables - see the include for details
  source config/ilias/reset_client.sh.inc || exit
}

function main {
  load_config
  if [ "$BACKUP_DIR" ]; then
    create_backup_dir;
  fi
  replace_data_dir_intern
  replace_data_dir_extern
  replace_database
}

function echoinfo { echo "II: $@"; }
function echoerr { echo "EE: $@" 1>&2; }

function assert_exists {
  if [ ! -e "$1" ]; then
    echoerr "file or directory does not exist: $1"
    exit 1
  fi
}

function assert_not_exists {
  if [ -e "$1" ]; then
    echoerr "file or directory already exist: $1"
    exit 1
  fi
}

function assert_is_dir {
  if [ ! -d "$1" ]; then
    echoerr "$2 is not a directory: $1"
    exit 1
  fi
}

function assert_backup_dir {
  assert_is_dir $BACKUP_DIR BACKUP_DIR
}

function assert_data_dirs_intern {
  assert_is_dir $DATA_DIR_INTERN_TARGET DATA_DIR_INTERN_TARGET
  assert_is_dir $DATA_DIR_INTERN_SOURCE DATA_DIR_INTERN_SOURCE
}

function assert_data_dirs_extern {
  assert_is_dir $DATA_DIR_EXTERN_TARGET DATA_DIR_EXTERN_TARGET
  assert_is_dir $DATA_DIR_EXTERN_SOURCE DATA_DIR_EXTERN_SOURCE
}

function echo_database_credentials {
  local credentials=""
  if [ "$DB_HOST" ]; then
    credentials+="--host=$DB_HOST "
  fi
  if [ "$DB_PORT" ]; then
    credentials+="--port=$DB_PORT "
  fi
  if [ "$DB_USER" ]; then
    credentials+="--user=$DB_USER "
  fi
  if [ "$DB_PASSWORD" ]; then
    credentials+="--password=$DB_PASSWORD "
  fi
  echo $credentials
}

function create_backup_dir {
  BACKUP_DIR="$BACKUP_BASEDIR/$(date +%Y-%m-%d_%H-%M-%S)"
  echoinfo "create backup directory: $BACKUP_DIR"
  assert_not_exists "$BACKUP_DIR"
  mkdir $BACKUP_DIR --parents || exit
}

function mv_to_backup {
  echoinfo "move to backup: $1"
  assert_exists "$1"
  assert_backup_dir
  mv "$1" "$BACKUP_DIR/$2" || exit
}

function backup_target_database {
  echoinfo "backup database: $DB_DATABASE_TARGET"
  DB_DATABASE_DUMP="$BACKUP_DIR/dump.sql"
  assert_backup_dir
  assert_not_exists "$DB_DATABASE_DUMP"
  mysqldump $(echo_database_credentials) --databases "$DB_DATABASE_TARGET" > "$DB_DATABASE_DUMP" || exit
}

function replace_data_dir_intern {
  echoinfo "reset internal datadir $DATA_DIR_INTERN_SOURCE -> $DATA_DIR_INTERN_TARGET"
  assert_data_dirs_intern
  if [ "$BACKUP_DIR" ]; then
    mv_to_backup $DATA_DIR_INTERN_TARGET "data_dir_intern"
  fi
  client_ini=$(cat $DATA_DIR_INTERN_TARGET/client.ini.php) || exit
  cp $DATA_DIR_INTERN_SOURCE $DATA_DIR_INTERN_TARGET -R || exit
  echoinfo "restore client.ini.php"
  echo "$client_ini" > $DATA_DIR_INTERN_TARGET/client.ini.php || exit
}

function replace_data_dir_extern {
  echoinfo "reset external datadir $DATA_DIR_EXTERN_SOURCE -> $DATA_DIR_EXTERN_TARGET"
  assert_data_dirs_extern
  if [ "$BACKUP_DIR" ]; then
    mv_to_backup $DATA_DIR_EXTERN_TARGET "data_dir_extern"
  fi
  cp $DATA_DIR_EXTERN_SOURCE $DATA_DIR_EXTERN_TARGET -R || exit
}

function replace_database {
  echoinfo "reset database $DB_DATABASE_SOURCE -> $DB_DATABASE_TARGET"
  if [ "$BACKUP_DIR" ]; then
    backup_target_database
  fi
  echoinfo "drop existing database: $DB_DATABASE_TARGET"
  mysql $(echo_database_credentials) --execute="DROP DATABASE IF EXISTS $DB_DATABASE_TARGET;" || exit
  echoinfo "re-import from database template: $DB_DATABASE_SOURCE"
  mysqldump $(echo_database_credentials) --databases "$DB_DATABASE_SOURCE" \
    | sed "/^CREATE DATABASE\|USE\|--/ s=$DB_DATABASE_SOURCE=$DB_DATABASE_TARGET=" \
    | mysql $(echo_database_credentials) || exit
}

function base_dir {
  if hash readlink 2>/dev/null; then
    # use readlink, if installed, to follow symlinks
    local __DIR="$(dirname "$(readlink -f "$0")")"
  else
    local __DIR="$(dirname "$0")"
  fi
  echo ${__DIR}
}

(cd "$(base_dir)/../../../" && main $@)
