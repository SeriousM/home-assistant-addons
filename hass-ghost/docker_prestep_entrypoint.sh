#!/bin/sh

CONFIG_PATH="/data/options.json"
GHOST_PATH_LOCAL="/data/ghost"

GHOST_DATA_STORAGE="/var/lib/ghost/content"
GHOST_DATA_STORAGE_ORIG="/var/lib/ghost/content.orig"

mkdir -p "${GHOST_PATH_LOCAL}"

#####################
##  STARTUP DEBUG  ##
#####################
echo "Start ghost"
echo "CONFIG:"

cat $CONFIG_PATH

echo "Set env variables"
#####################
## USER PARAMETERS ##
#####################

# REQUIRED


# ENVs: https://ghost.org/docs/config/
# For nested config options, separate with two underscores, eg. "database__connection__host"
# defaults as they are set: https://github.com/TryGhost/Ghost/blob/c667620d8f2e32c96fe376ad0f3dabc79488532a/ghost/core/core/shared/config/defaults.json

# ensure that ghost instance will write the data into the /data/ghost folder which will be backed up by home assistant
export paths__contentPath=$GHOST_PATH_LOCAL

export NODE_ENV="$(jq --raw-output '.app_env // empty' $CONFIG_PATH)"


# Set the public URL for your blog
export url="$(jq --raw-output '.app_url // empty' $CONFIG_PATH)"

# Type of database used (default: MySQL)
export database__connection__host="$(jq --raw-output '.db_host // empty' $CONFIG_PATH)"
export database__connection__port="$(jq --raw-output '.db_port // empty' $CONFIG_PATH)"
export database__connection__user="$(jq --raw-output '.db_username // empty' $CONFIG_PATH)"
export database__connection__password="$(jq --raw-output '.db_password // empty' $CONFIG_PATH)"
export database__connection__database="$(jq --raw-output '.db_database // empty' $CONFIG_PATH)"

export mail__from="$(jq --raw-output '.mail_from_address // empty' $CONFIG_PATH)"
export mail__options__service="$(jq --raw-output '.mail_mailer // empty' $CONFIG_PATH)"
export mail__options__host="$(jq --raw-output '.mail_host // empty' $CONFIG_PATH)"
export mail__options__port="$(jq --raw-output '.mail_port // empty' $CONFIG_PATH)"
export mail__options__secure="$(jq --raw-output '.mail_secure // empty' $CONFIG_PATH)"
export mail__options__auth__user="$(jq --raw-output '.mail_username // empty' $CONFIG_PATH)"
export mail__options__auth__pass="$(jq --raw-output '.mail_password // empty' $CONFIG_PATH)"

export privacy__useUpdateCheck="$(jq --raw-output '.privacy_useUpdateCheck // empty' $CONFIG_PATH)"
export privacy__useGravatar="$(jq --raw-output '.privacy_useGravatar // empty' $CONFIG_PATH)"
export privacy__useRpcPing="$(jq --raw-output '.privacy_useRpcPing // empty' $CONFIG_PATH)"
export privacy__useStructuredData="$(jq --raw-output '.privacy_useStructuredData // empty' $CONFIG_PATH)"

# ADD "if mail, then emit" or more like "if not mail, remove export again" with "unset NAME"

echo "Done env variables"

###########
## MAIN  ##
###########
echo "Main"

# # copy all files from the docker data dir into local data dir, then link it
# echo "ensure data directory link"
# if [ -d ${GHOST_PATH_LOCAL} ] ; then
#   echo "-d ${GHOST_PATH_LOCAL}"
  
#   # in case the content folder is the original one, we need to delete it (it's empty anyway)
#   # to ensure we can create a symlink to the /data/ghost folder
#   if [ -d ${GHOST_DATA_STORAGE} ] && (! test -L ${GHOST_DATA_STORAGE}); then
#     rm -rf ${GHOST_DATA_STORAGE}
#   fi

#   ln -s ${GHOST_PATH_LOCAL} ${GHOST_DATA_STORAGE}
  
#   chmod -R 777 ${GHOST_PATH_LOCAL}
# fi

echo "check content folder structure"
for origDir in $(ls ${GHOST_DATA_STORAGE_ORIG})
do
  if [ ! -d ${GHOST_PATH_LOCAL}/${origDir} ] ; then
    echo "create ${GHOST_PATH_LOCAL}/${origDir} directory and copy original content into it"
    # R: recursive, L: copy files from symlinks as files, n: don't overwrite anything
    cp -RLn ${GHOST_DATA_STORAGE_ORIG}/${origDir} ${GHOST_PATH_LOCAL}/${origDir}
    chmod -R 777 ${GHOST_PATH_LOCAL}
  fi
done

echo "last step"

exec node current/index.js