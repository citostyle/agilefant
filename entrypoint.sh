#/bin/sh

CONFIG_FILE=/usr/local/tomcat/webapps/agilefant/WEB-INF/agilefant.conf
SLEEP_TIME=10

sed -i -e"s/password\s*=\s*\"agilefant\"/password = \"$DB_ENV_MYSQL_PASSWORD\"/" "$CONFIG_FILE"

echo "Wait $SLEEP_TIME sec for database to be ready"
sleep $SLEEP_TIME

catalina.sh run 
