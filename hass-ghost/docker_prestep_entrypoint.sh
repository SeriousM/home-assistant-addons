#!/bin/sh

CONFIG_PATH="/data/options.json"
GHOST_PATH_LOCAL="/data/ghost"

GHOST_DATA_STORAGE="/var/lib/ghost/content"

mkdir -p "${GHOST_PATH_LOCAL}"
# don't create the folder of monica, we'll need to link the data folder there
# which is not possible if the target folder exists.
# mkdir -p "${GHOST_DATA_STORAGE}"

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

export NODE_ENV="$(jq --raw-output '.app_env // empty' $CONFIG_PATH)"


# Set the public URL for your blog
export url="$(jq --raw-output '.app_url // empty' $CONFIG_PATH)"

# Type of database used (default: MySQL)
export database__connection__host="$(jq --raw-output '.database_host // empty' $CONFIG_PATH)"
export database__connection__port="$(jq --raw-output '.database_port // empty' $CONFIG_PATH)"
export database__connection__user="$(jq --raw-output '.database_user // empty' $CONFIG_PATH)"
export database__connection__password="$(jq --raw-output '.database_pass // empty' $CONFIG_PATH)"
export database__connection__database="$(jq --raw-output '.database_db // empty' $CONFIG_PATH)"

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

# # Add a mail service
# export mail="$(jq --raw-output '.mail // empty' $CONFIG_PATH)"
# # Set mail from
# export mail__from="$(jq --raw-output '.mail_from // empty' $CONFIG_PATH)"
# export mail__transport="SMTP"

# ADD "if mail, then emit" or more like "if not mail, remove export again" with "unset NAME"
# "mail": {
#   "transport": "SMTP",
#   "options": {
#     "service": "Mailgun",
#     "host": "smtp.mailgun.org",
#     "port": 465,
#     "secure": true,
#     "auth": {
#       "user": "postmaster@example.mailgun.org",
#       "pass": "1234567890"
#     }
#   }
# }











# #
# # Welcome, friend ❤. Thanks for trying out Monica. We hope you'll have fun.
# #

# # Two choices: local|production. Use local if you want to install Monica as a
# # development version. Use production otherwise.
# export APP_ENV="$(jq --raw-output '.app_env // empty' $CONFIG_PATH)"

# # true if you want to show debug information on errors. For production, put this
# # to false.
# export APP_DEBUG="$(jq --raw-output '.app_debug // empty' $CONFIG_PATH)"

# # The encryption key. This is the most important part of the application. Keep
# # this secure otherwise, everyone will be able to access your application.
# # Must be 32 characters long exactly.
# # Use `php artisan key:generate` or `echo -n 'base64:'; openssl rand -base64 32` to generate a random key.
# export APP_KEY="$(jq --raw-output '.app_key // empty' $CONFIG_PATH)"

# # Prevent information leakage by referring to IDs with hashIds instead of
# # the actual IDs used in the database.
# export HASH_SALT="$(jq --raw-output '.hash_salt // empty' $CONFIG_PATH)"
# export HASH_LENGTH="$(jq --raw-output '.hash_length // empty' $CONFIG_PATH)"

# # The URL of your application.
# export APP_URL="$(jq --raw-output '.app_url // empty' $CONFIG_PATH)"

# # Force using APP_URL as base url of your application.
# # You should not need this, unless you are using subdirectory config.
# export APP_FORCE_URL="$(jq --raw-output '.app_force_url // empty' $CONFIG_PATH)"

# # Database information
# # To keep this information secure, we urge you to change the default password
# # Currently only "mysql" compatible servers are working
# export DB_CONNECTION="$(jq --raw-output '.db_connection // empty' $CONFIG_PATH)"
# export DB_HOST="$(jq --raw-output '.db_host // empty' $CONFIG_PATH)"
# export DB_PORT="$(jq --raw-output '.db_port // empty' $CONFIG_PATH)"
# # You can use mysql unix socket if available, it overrides DB_HOST and DB_PORT values.
# #export DB_UNIX_SOCKET="$(jq --raw-output '.#db_unix_socket // empty' $CONFIG_PATH)"
# export DB_DATABASE="$(jq --raw-output '.db_database // empty' $CONFIG_PATH)"
# export DB_USERNAME="$(jq --raw-output '.db_username // empty' $CONFIG_PATH)"
# export DB_PASSWORD="$(jq --raw-output '.db_password // empty' $CONFIG_PATH)"
# export DB_PREFIX="$(jq --raw-output '.db_prefix // empty' $CONFIG_PATH)"
# export DB_TEST_HOST="$(jq --raw-output '.db_test_host // empty' $CONFIG_PATH)"
# export DB_TEST_PORT="$(jq --raw-output '.db_test_port // empty' $CONFIG_PATH)"
# export DB_TEST_DATABASE="$(jq --raw-output '.db_test_database // empty' $CONFIG_PATH)"
# export DB_TEST_USERNAME="$(jq --raw-output '.db_test_username // empty' $CONFIG_PATH)"
# export DB_TEST_PASSWORD="$(jq --raw-output '.db_test_password // empty' $CONFIG_PATH)"

# # Use utf8mb4 database charset format to support emoji characters
# # ⚠ be sure your DBMS supports utf8mb4 format
# export DB_USE_UTF8MB4="$(jq --raw-output '.db_use_utf8mb4 // empty' $CONFIG_PATH)"

# # Mail credentials used to send emails from the application.
# export MAIL_MAILER="$(jq --raw-output '.mail_mailer // empty' $CONFIG_PATH)"
# export MAIL_HOST="$(jq --raw-output '.mail_host // empty' $CONFIG_PATH)"
# export MAIL_PORT="$(jq --raw-output '.mail_port // empty' $CONFIG_PATH)"
# export MAIL_USERNAME="$(jq --raw-output '.mail_username // empty' $CONFIG_PATH)"
# export MAIL_PASSWORD="$(jq --raw-output '.mail_password // empty' $CONFIG_PATH)"
# export MAIL_ENCRYPTION="$(jq --raw-output '.mail_encryption // empty' $CONFIG_PATH)"
# # Outgoing emails will be sent with these identity
# export MAIL_FROM_ADDRESS="$(jq --raw-output '.mail_from_address // empty' $CONFIG_PATH)"
# export MAIL_FROM_NAME="$(jq --raw-output '.mail_from_name // empty' $CONFIG_PATH)"
# # New registration notification sent to this email
# export APP_EMAIL_NEW_USERS_NOTIFICATION="$(jq --raw-output '.app_email_new_users_notification // empty' $CONFIG_PATH)"

# # Ability to disable signups on your instance.
# # Can be true or false. Default to false.
# export APP_DISABLE_SIGNUP="$(jq --raw-output '.app_disable_signup // empty' $CONFIG_PATH)"

# # Enable user email verification.
# export APP_SIGNUP_DOUBLE_OPTIN="$(jq --raw-output '.app_signup_double_optin // empty' $CONFIG_PATH)"

# # Set trusted proxy IP addresses.
# # To trust all proxies that connect directly to your server, use a "*".
# # To trust one or more specific proxies that connect directly to your server,
# # use a comma separated list of IP addresses.
# export APP_TRUSTED_PROXIES="$(jq --raw-output '.app_trusted_proxies // empty' $CONFIG_PATH)"

# # Enable automatic cloudflare trusted proxy discover
# export APP_TRUSTED_CLOUDFLARE="$(jq --raw-output '.app_trusted_cloudflare // empty' $CONFIG_PATH)"

# # Frequency of creation of new log files. Logs are written when an error occurs.
# # Refer to config/logging.php for the possible values.
# export LOG_CHANNEL="$(jq --raw-output '.log_channel // empty' $CONFIG_PATH)"

# # Error tracking. Specific to hosted version on .com. You probably don't need
# # those.
# export SENTRY_SUPPORT="$(jq --raw-output '.sentry_support // empty' $CONFIG_PATH)"
# export SENTRY_LARAVEL_DSN="$(jq --raw-output '.sentry_laravel_dsn // empty' $CONFIG_PATH)"

# # Send a daily ping to https://version.monicahq.com to check if a new version
# # is available. When a new version is detected, you will have a message in the
# # UI, as well as the release notes for the new changes. Can be true or false.
# # Default to true.
# export CHECK_VERSION="$(jq --raw-output '.check_version // empty' $CONFIG_PATH)"

# # Cache, session, and queue parameters
# # ⚠ Change this only if you know what you are doing
# #. Cache: database, file, memcached, redis, dynamodb
# #. Session: file, cookie, database, apc, memcached, redis, array
# #. Queue: sync, database, beanstalkd, sqs, redis
# #  If Queue is not set to 'sync', you'll have to set a queue worker
# #  See https://laravel.com/docs/5.7/queues#running-the-queue-worker
# export CACHE_DRIVER="$(jq --raw-output '.cache_driver // empty' $CONFIG_PATH)"
# export SESSION_DRIVER="$(jq --raw-output '.session_driver // empty' $CONFIG_PATH)"
# export SESSION_LIFETIME="$(jq --raw-output '.session_lifetime // empty' $CONFIG_PATH)"
# export QUEUE_CONNECTION="$(jq --raw-output '.queue_connection // empty' $CONFIG_PATH)"

# # If you use redis, set the redis host or ip, like:
# #export REDIS_HOST="$(jq --raw-output '.#redis_host // empty' $CONFIG_PATH)"

# # Maximum allowed size for uploaded files, in kilobytes.
# # Make sure this is an integer, without commas or spaces.
# export DEFAULT_MAX_UPLOAD_SIZE="$(jq --raw-output '.default_max_upload_size // empty' $CONFIG_PATH)"

# # Maximum allowed storage size per account, in megabytes.
# # Make sure this is an integer, without commas or spaces.
# export DEFAULT_MAX_STORAGE_SIZE="$(jq --raw-output '.default_max_storage_size // empty' $CONFIG_PATH)"

# # Default filesystem to store uploaded files.
# # Possible values: public|s3
# export FILESYSTEM_DISK="$(jq --raw-output '.filesystem_disk // empty' $CONFIG_PATH)"

# # AWS keys for S3 when using this storage method
# export AWS_KEY="$(jq --raw-output '.aws_key // empty' $CONFIG_PATH)"
# export AWS_SECRET="$(jq --raw-output '.aws_secret // empty' $CONFIG_PATH)"
# export AWS_REGION="$(jq --raw-output '.aws_region // empty' $CONFIG_PATH)"
# export AWS_BUCKET="$(jq --raw-output '.aws_bucket // empty' $CONFIG_PATH)"
# export AWS_SERVER="$(jq --raw-output '.aws_server // empty' $CONFIG_PATH)"

# # Set to true if you use S3 and need path style URL support for bucket access
# # The default is to use virtual-hosted style URLs which may not work everywhere
# export S3_PATH_STYLE="$(jq --raw-output '.s3_path_style // empty' $CONFIG_PATH)"

# # Allow Two Factor Authentication feature on your instance
# export MFA_ENABLED="$(jq --raw-output '.mfa_enabled // empty' $CONFIG_PATH)"

# # Enable DAV support
# export DAV_ENABLED="$(jq --raw-output '.dav_enabled // empty' $CONFIG_PATH)"

# # CLIENT ID and SECRET used for OAuth authentication
# export PASSPORT_PASSWORD_GRANT_CLIENT_ID="$(jq --raw-output '.passport_password_grant_client_id // empty' $CONFIG_PATH)"
# export PASSPORT_PASSWORD_GRANT_CLIENT_SECRET="$(jq --raw-output '.passport_password_grant_client_secret // empty' $CONFIG_PATH)"

# # Allow to access general statistics about your instance through a public API
# # call
# export ALLOW_STATISTICS_THROUGH_PUBLIC_API_ACCESS="$(jq --raw-output '.allow_statistics_through_public_api_access // empty' $CONFIG_PATH)"

# # Indicates that each user in the instance must comply to international policies
# # like CASL or GDPR
# export POLICY_COMPLIANT="$(jq --raw-output '.policy_compliant // empty' $CONFIG_PATH)"

# # Enable geolocation services
# # This is used to translate addresses to GPS coordinates.
# export ENABLE_GEOLOCATION="$(jq --raw-output '.enable_geolocation // empty' $CONFIG_PATH)"

# # API key for geolocation services
# # We use LocationIQ (https://locationiq.com/) to translate addresses to
# # latitude/longitude coordinates. We could use Google instead but we don't
# # want to give anything to Google, ever.
# # LocationIQ offers 5000 free requests per day.
# export LOCATION_IQ_API_KEY="$(jq --raw-output '.location_iq_api_key // empty' $CONFIG_PATH)"

# # Enable weather on contact profile page
# # Weather can only be fetched if we know longitude/latitude - this is why
# # you also need to activate the geolocation service above to make it work
# export ENABLE_WEATHER="$(jq --raw-output '.enable_weather // empty' $CONFIG_PATH)"

# # Access to weather data from darksky api
# # https://www.weatherapi.com/signup.aspx
# # You need to enable the weather above if you provide an API key here.
# export WEATHERAPI_KEY="$(jq --raw-output '.weatherapi_key // empty' $CONFIG_PATH)"

# # Configure rate limits for RouteService per minute
# export RATE_LIMIT_PER_MINUTE_API="$(jq --raw-output '.rate_limit_per_minute_api // empty' $CONFIG_PATH)"
# export RATE_LIMIT_PER_MINUTE_OAUTH="$(jq --raw-output '.rate_limit_per_minute_oauth // empty' $CONFIG_PATH)"


echo "Done env variables"

###########
## MAIN  ##
###########
echo "Main"
if [ -d ${GHOST_PATH_LOCAL} ] ; then
  echo "-d ${GHOST_PATH_LOCAL}"
  #chmod o+rx ${GHOST_PATH_LOCAL}
  chmod -R 777 ${GHOST_PATH_LOCAL}
  # chmod -R 777 ${GHOST_DATA_STORAGE}
  #chown -R node ${GHOST_PATH_LOCAL}/.n8n
  ln -s ${GHOST_PATH_LOCAL} ${GHOST_DATA_STORAGE}
fi

#echo "chmod"
#chmod -R 777 /usr/local/lib/node_modules/n8n
#chmod -R 777 /home/node
#chown -R node /home/node

echo "last step"

echo "Got started arguments: $@"

exec node current/index.js