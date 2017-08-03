#!/bin/bash 

# Restart postgres to make sure we can connect
pg_ctl -D "$PGDATA" -m fast -o "$LOCALONLY" -w restart

# ci creation scripts
java -DMLR_LEGACY_DATA_PASSWORD=$MLR_LEGACY_DATA_PASSWORD -DMLR_LEGACY_USER_PASSWORD=$MLR_LEGACY_USER_PASSWORD -jar ${LIQUIBASE_HOME}/liquibase.jar \
	--defaultsFile=${LIQUIBASE_HOME}/liquibase.properties \
	--classpath=${LIQUIBASE_HOME}/lib/postgresql-${POSTGRES_JDBC_VERSION}.jar \
	--changeLogFile=${JENKINS_WORKSPACE}/MLR_Legacy_DB/liquibase/changeLog.xml \
	--contexts=ci \
update > $LIQUIBASE_HOME/liquibase.log