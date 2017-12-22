#!/bin/bash

CONTAINER_IP=$(hostname -i)
EXTERNAL_IP="${EXTERNAL_IP:-}"
BOT_PORT="${BOT_PORT:-12360}"
MYSQL_HOST="${MYSQL_HOST:-mysql}"
MYSQL_PORT="${MYSQL_PORT:-3306}"
MYSQL_USER="${MYSQL_USER:-ebotv3}"
MYSQL_PASS="${MYSQL_PASS:-ebotv3}"
MYSQL_DB="${MYSQL_DB:-ebotv3}"

SSL_ENABLED="${SSL_ENABLED:-false}"
SSL_CERTIFICATE_PATH="${SSL_CERTIFICATE_PATH:-ssl/cert.pem}"
SSL_KEY_PATH="${SSL_KEY_PATH:-ssl/key.pem}"

MANAGE_PLAYER="${MANAGE_PLAYER:-1}"
DELAY_BUSY_SERVER="${DELAY_BUSY_SERVER:-120}"
NB_MAX_MATCHS="${NB_MAX_MATCHS:-0}"
PAUSE_METHOD="${PAUSE_METHOD:-nextRound}"

MAP="${MAP:-['de_dust2_se','de_nuke_se','de_inferno_se','de_mirage_ce','de_train_se','de_cache','de_season','de_dust2','de_nuke','de_inferno','de_train','de_mirage','de_cbble','de_overpass']}"

COMMAND_STOP_DISABLED="${COMMAND_STOP_DISABLED:-false}"
RECORD_METHOD="${RECORD_METHOD:-matchstart}"

LO3_METHOD="${LO3_METHOD:-restart}"
KO3_METHOD="${KO3_METHOD:-restart}"
DEMO_DOWNLOAD="${DEMO_DOWNLOAD:-true}"
REMIND_RECORD="${REMIND_RECORD:-false}"
DAMAGE_REPORT="${DAMAGE_REPORT:-false}"
DELAY_READY="${DELAY_READY:-false}"
NODE_STARTUP_METHOD="${NODE_STARTUP_METHOD:-none}"
USE_DELAY_END_RECORD="${USE_DELAY_END_RECORD:-true}"

TOORNAMENT_PLUGIN_KEY="${TOORNAMENT_PLUGIN_KEY:-azertylol}"

# for usage with docker-compose
while ! nc -z $MYSQL_HOST $MYSQL_PORT; do sleep 3; done

echo 'date.timezone = "${TIMEZONE}"' >> /usr/local/etc/php/conf.d/php.ini

sed -i "s/BOT_IP =.*/BOT_IP = \"$CONTAINER_IP\"/g" $EBOT_HOME/config/config.ini
sed -i "s/BOT_PORT =.*/BOT_PORT = \"$BOT_PORT\"/g" $EBOT_HOME/config/config.ini
#sed -i "s/BOT_IP =.*/BOT_IP = \"$EXTERNAL_IP\"/g" $EBOT_HOME/config/config.ini
sed -i "s/EXTERNAL_LOG_IP = .*/EXTERNAL_LOG_IP = \"$EXTERNAL_IP\"/g" $EBOT_HOME/config/config.ini
sed -i "s/MYSQL_IP =.*/MYSQL_IP = \"$MYSQL_HOST\"/g" $EBOT_HOME/config/config.ini
sed -i "s/MYSQL_PORT =.*/MYSQL_PORT = \"$MYSQL_PORT\"/g" $EBOT_HOME/config/config.ini
sed -i "s/MYSQL_USER =.*/MYSQL_USER = \"$MYSQL_USER\"/g" $EBOT_HOME/config/config.ini
sed -i "s/MYSQL_PASS =.*/MYSQL_PASS = \"$MYSQL_PASS\"/g" $EBOT_HOME/config/config.ini
sed -i "s/MYSQL_BASE =.*/MYSQL_BASE = \"$MYSQL_DB\"/g" $EBOT_HOME/config/config.ini
sed -i "s/SSL_ENABLED =.*/SSL_ENABLED = $SSL_ENABLED/g" $EBOT_HOME/config/config.ini
sed -i "s/SSL_CERTIFICATE_PATH =.*/SSL_CERTIFICATE_PATH = \"$SSL_CERTIFICATE_PATH\"/g" $EBOT_HOME/config/config.ini
sed -i "s/SSL_KEY_PATH =.*/SSL_KEY_PATH = \"$SSL_KEY_PATH\"/g" $EBOT_HOME/config/config.ini
sed -i "s/MANAGE_PLAYER =.*/MANAGE_PLAYER = $MANAGE_PLAYER/g" $EBOT_HOME/config/config.ini
sed -i "s/DELAY_BUSY_SERVER =.*/DELAY_BUSY_SERVER = $DELAY_BUSY_SERVER/g" $EBOT_HOME/config/config.ini
sed -i "s/NB_MAX_MATCHS =.*/NB_MAX_MATCHS = $NB_MAX_MATCHS/g" $EBOT_HOME/config/config.ini
sed -i "s/PAUSE_METHOD =.*/PAUSE_METHOD = \"$PAUSE_METHOD\"/g" $EBOT_HOME/config/config.ini
sed -i "s/MAP =.*/MAP = $MAP/g" $EBOT_HOME/config/config.ini
sed -i "s/COMMAND_STOP_DISABLED =.*/COMMAND_STOP_DISABLED = $COMMAND_STOP_DISABLED/g" $EBOT_HOME/config/config.ini
sed -i "s/RECORD_METHOD =.*/RECORD_METHOD = \"$RECORD_METHOD\"/g" $EBOT_HOME/config/config.ini
sed -i "s/LO3_METHOD =.*/LO3_METHOD = \"$LO3_METHOD\"/g" $EBOT_HOME/config/config.ini
sed -i "s/KO3_METHOD =.*/KO3_METHOD = \"$KO3_METHOD\"/g" $EBOT_HOME/config/config.ini
sed -i "s/DEMO_DOWNLOAD =.*/DEMO_DOWNLOAD = $DEMO_DOWNLOAD/g" $EBOT_HOME/config/config.ini
sed -i "s/REMIND_RECORD =.*/REMIND_RECORD = $REMIND_RECORD/g" $EBOT_HOME/config/config.ini
sed -i "s/DAMAGE_REPORT =.*/DAMAGE_REPORT = $DAMAGE_REPORT/g" $EBOT_HOME/config/config.ini
sed -i "s/NODE_STARTUP_METHOD =.*/NODE_STARTUP_METHOD = $NODE_STARTUP_METHOD/g" $EBOT_HOME/config/config.ini
sed -i "s/DELAY_READY = .*/DELAY_READY = $DELAY_READY/g" $EBOT_HOME/config/config.ini
sed -i "s/USE_DELAY_END_RECORD = .*/USE_DELAY_END_RECORD = \"$USE_DELAY_END_RECORD\"/g" $EBOT_HOME/config/config.ini

echo -e "\n" >> $EBOT_HOME/config/plugins.ini
echo '[\eBot\Plugins\Official\ToornamentNotifier]' >> $EBOT_HOME/config/plugins.ini
echo "url=http://${EXTERNAL_IP}/matchs/toornament/export/{MATCH_ID}" >> $EBOT_HOME/config/plugins.ini
echo "key=${TOORNAMENT_PLUGIN_KEY}" >> $EBOT_HOME/config/plugins.ini

exec php "$EBOT_HOME/bootstrap.php" 

