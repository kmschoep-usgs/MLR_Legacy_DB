#!/bin/bash 

# Restart postgres to make sure we can connect
pg_ctl -D "$PGDATA" -m fast -o "$LOCALONLY" -w restart

# superuser scripts
${LIQUIBASE_HOME}/liquibase \
--defaultsFile=${LIQUIBASE_HOME}/postgres.properties \
--classpath=${LIQUIBASE_HOME}/lib/postgresql-${POSTGRES_JDBC_VERSION}.jar \
--changeLogFile=${LIQUIBASE_HOME}/mlr-liquibase/postgres/changeLog.yml \
--logLevel=debug \
update \
-DMLR_LEGACY_PASSWORD=${MLR_LEGACY_PASSWORD} > ${LIQUIBASE_HOME}/liquibaseSuperuser.log

# application database create scripts
${LIQUIBASE_HOME}/liquibase \
--defaultsFile=${LIQUIBASE_HOME}/databaseCreate.properties \
--classpath=${LIQUIBASE_HOME}/lib/postgresql-${POSTGRES_JDBC_VERSION}.jar \
--changeLogFile=${LIQUIBASE_HOME}/mlr-liquibase/database/changeLog.yml \
--logLevel=debug \
update > ${LIQUIBASE_HOME}/liquibaseDatabaseCreate.log

# application scripts
${LIQUIBASE_HOME}/liquibase \
--defaultsFile=${LIQUIBASE_HOME}/liquibase.properties \
--classpath=${LIQUIBASE_HOME}/lib/postgresql-${POSTGRES_JDBC_VERSION}.jar \
--changeLogFile=${LIQUIBASE_HOME}/mlr-liquibase/changeLog.yml \
--logLevel=debug \
update \
-DMLR_LEGACY_DATA_PASSWORD=${MLR_LEGACY_DATA_PASSWORD} -DMLR_LEGACY_USER_PASSWORD=${MLR_LEGACY_USER_PASSWORD} > ${LIQUIBASE_HOME}/liquibase.log
