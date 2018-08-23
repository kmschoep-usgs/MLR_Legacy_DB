#!/bin/ash 

# Restart postgres to make sure we can connect
pg_ctl -D "$PGDATA" -m fast -o "$LOCALONLY" -w restart

# superuser scripts
${LIQUIBASE_HOME}/liquibase \
--defaultsFile=${LIQUIBASE_HOME}/mlr-legacy-liquibase/mlr-liquibase/postgres.properties \
--classpath=${LIQUIBASE_HOME}/lib/postgresql.jar \
--changeLogFile=${LIQUIBASE_HOME}/mlr-legacy-liquibase/mlr-liquibase/postgres/postgres/changeLog.yml \
--url=jdbc:postgresql://127.0.0.1:5432/postgres \
--logLevel=debug \
update \
	-DPOSTGRES_PASSWORD=${POSTGRES_PASSWORD} \
	-DMLR_LEGACY_PASSWORD=${MLR_LEGACY_PASSWORD} \
	-DMLR_LEGACY_USER_PASSWORD=${MLR_LEGACY_USER_PASSWORD} 

# application database create scripts
${LIQUIBASE_HOME}/liquibase \
--defaultsFile=${LIQUIBASE_HOME}/mlr-legacy-liquibase/mlr-liquibase/databaseCreate.properties \
--classpath=${LIQUIBASE_HOME}/lib/postgresql.jar \
--changeLogFile=${LIQUIBASE_HOME}/mlr-legacy-liquibase/mlr-liquibase/postgres/mlr_legacy/changeLog.yml \
--url=jdbc:postgresql://127.0.0.1:5432/mlr_legacy \
--logLevel=debug \
update \
	-DPOSTGRES_PASSWORD=${POSTGRES_PASSWORD} 

# application scripts
${LIQUIBASE_HOME}/liquibase \
--defaultsFile=${LIQUIBASE_HOME}/mlr-legacy-liquibase/mlr-liquibase/liquibase.properties \
--classpath=${LIQUIBASE_HOME}/lib/postgresql.jar \
--changeLogFile=${LIQUIBASE_HOME}/mlr-legacy-liquibase/mlr-liquibase/mlr_legacy/changeLog.yml \
--url=jdbc:postgresql://127.0.0.1:5432/mlr_legacy \
--logLevel=debug \
update \
	-DMLR_LEGACY_PASSWORD=${MLR_LEGACY_PASSWORD} \
	-DMLR_LEGACY_USER_PASSWORD=${MLR_LEGACY_USER_PASSWORD} 

echo "data load scripts"
${LIQUIBASE_HOME}/liquibase \
--defaultsFile=${LIQUIBASE_HOME}/mlr-legacy-liquibase/mlr-liquibase/liquibase.properties \
--classpath=${LIQUIBASE_HOME}/lib/postgresql.jar \
--changeLogFile=${LIQUIBASE_HOME}/mlr-legacy-liquibase/mlr-liquibase/mlr_legacy/testData/changeLogAK.yml \
--url=jdbc:postgresql://127.0.0.1:5432/mlr_legacy \
--logLevel=debug \
update \
	-DMLR_LEGACY_PASSWORD=${MLR_LEGACY_PASSWORD}
