#!/usr/bin/env bash

LIQUIBASE_SCRIPT_HOME=/home/drsteini/tools/git/MLR/MLR_Legacy_DB
LIQUIBASE_HOME=/home/drsteini/tools/liquibase/3.5.3
POSTGRES_JDBC_VERSION=42.1.3
POSTGRES_JDBC_LOC=/home/drsteini/tools
MLR_LEGACY_DATA_PASSWORD=mlr
MLR_LEGACY_USER_PASSWORD=mlr

${LIQUIBASE_HOME}/liquibase \
--defaultsFile=${LIQUIBASE_SCRIPT_HOME}/dbInit/liquibase.properties \
--classpath=${POSTGRES_JDBC_LOC}/postgresql-${POSTGRES_JDBC_VERSION}.jar \
--changeLogFile=${LIQUIBASE_SCRIPT_HOME}/mlr-liquibase/changeLog.yml \
--logLevel=debug \
update \
-DMLR_LEGACY_DATA_PASSWORD=${MLR_LEGACY_DATA_PASSWORD} -DMLR_LEGACY_USER_PASSWORD=${MLR_LEGACY_USER_PASSWORD}

