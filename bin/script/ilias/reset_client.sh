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
  create_backup_dir
  replace_data_dir_intern
  replace_data_dir_extern
  replace_database
}

fn echoerr() { echo "ERROR: $@" 1>&2; }

fn assert_exists {
  if [ ! -e "$1" ]; then
    echoerr "file or directory does not exist: $1"
    exit 1
  fi
}

fn assert_not_exists {
  if [ -e "$1" ]; then
    echoerr "file or directory already exist: $1"
    exit 1
  fi
}

fn assert_is_dir {
  if [ ! -d "$1"]; then
    echoerr "$2 is not a directory: $1"
    exit 1
  fi
}

fn assert_backup_dir {
  assert_is_dir $BACKUP_DIR BACKUP_DIR
}

fn assert_data_dirs_intern {
  assert_is_dir $DATA_DIR_INTERN_TARGET DATA_DIR_INTERN_TARGET
  assert_is_dir $DATA_DIR_INTERN_SOURCE DATA_DIR_INTERN_SOURCE
}

fn assert_data_dirs_extern {
  assert_is_dir $DATA_DIR_EXTERN_TARGET DATA_DIR_EXTERN_TARGET
  assert_is_dir $DATA_DIR_EXTERN_SOURCE DATA_DIR_EXTERN_SOURCE
}

fn echo_database_credentials {
  echo "--host=\"$DB_HOST\" --port=\"$DB_PORT\" --user=\"$DB_USER\" --password=\"$DB_PASSWORD\""
}

fn create_backup_dir {
  $BACKUP_DIR = $BACKUP_BASEDIR + $(date +"%Y-%m-%d_%H-%M-%S")
  echo "create backup directory: $BACKUP_DIR"
  assert_not_exists "$BACKUP_DIR"
  mkdir $BACKUP_DIR || exit
}

fn mv_to_backup {
  echo "move to backup: $1"
  assert_exists "$1"
  assert_backup_dir
  mv "$1" "$BACKUP_DIR/" || exit
}

fn backup_target_database {
  echo "backup database: $DB_DATABASE_TARGET"
  $DB_DATABASE_DUMP = "$BACKUP_DIR/dump.sql"
  assert_backup_dir
  assert_not_exists "$DB_DATABASE_DUMP"
  mysqldump $(echo_database_credentials) --databases "$DB_DATABASE_TARGET" > "$DB_DATABASE_DUMP" || exit
}

fn replace_data_dir_intern {
  echo "reset internal datadir $DATA_DIR_INTERN_SOURCE -> $DATA_DIR_INTERN_TARGET"
  assert_data_dirs_intern
  mv_to_backup $DATA_DIR_INTERN_TARGET 
  cp $DATA_DIR_INTERN_SOURCE $DATA_DIR_INTERN_TARGET -R || exit
}

fn replace_data_dir_extern {
  echo "reset external datadir $DATA_DIR_EXTERN_SOURCE -> $DATA_DIR_EXTERN_TARGET"
  assert_data_dirs_extern
  mv_to_backup $DATA_DIR_EXTERN_TARGET
  cp $DATA_DIR_EXTERN_SOURCE $DATA_DIR_EXTERN_TARGET -R || exit
}

fn replace_database {
  echo "reset database $DB_DATABASE_SOURCE -> $DB_DATABASE_TARGET"
  backup_target_database
  echo "drop (old) target database: $DB_DATABASE_TARGET"

  echo "copy database: "
  mysqldump $(echo_database_credentials) "$DB_DATABASE_SOURCE" | mysql $(echo_database_credentials) "$DB_DATABASE_TARGET" || exit
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
