FROM mdillon/postgis:10-alpine

LABEL maintainer="gs-w_eto_eb_federal_employees@usgs.gov"

############################################
# Required for JRE 8 - Java 8 is required to run the Liquibase JAR - lifted from https://github.com/docker-library/openjdk
############################################

RUN { \
		echo '#!/bin/sh'; \
		echo 'set -e'; \
		echo; \
		echo 'dirname "$(dirname "$(readlink -f "$(which javac || which java)")")"'; \
	} > /usr/local/bin/docker-java-home \
	&& chmod +x /usr/local/bin/docker-java-home
ENV JAVA_HOME /usr/lib/jvm/java-1.8-openjdk
ENV PATH $PATH:$JAVA_HOME/bin

RUN set -x \
    apt update && \
	apk add --no-cache \
	curl openjdk8 git openssh && \
	apk add --no-cache -u libxml2 && \
	rm -rf /var/lib/apt/lists/*

############################################
# Install Liquibase
############################################
ENV SSL_CERT_FILE=/etc/ssl/certs/ca-certificates.crt
ENV LIQUIBASE_HOME /opt/liquibase
ENV LOCALONLY "-c listen_addresses='127.0.0.1, ::1'"
ENV LIQUIBASE_VERSION 3.5.3
ENV POSTGRES_JDBC_VERSION postgresql-42.2.4.jar
ENV MLR_LIQUIBASE_VERSION master
ENV MLR_LEGACY_DATABASE_NAME mlr_legacy
ENV MLR_LEGACY mlr_legacy
ENV MLR_LEGACY_USER mlr_legacy_user
ENV MLR_LEGACY_SCHEMA_NAME mlr_legacy_data

RUN if getent ahosts "sslhelp.doi.net" > /dev/null 2>&1; then \
                wget 'https://s3-us-west-2.amazonaws.com/prod-owi-resources/resources/InstallFiles/SSL/DOIRootCA.cer' -O /usr/local/share/ca-certificates/DOIRootCA2.crt && \
                update-ca-certificates; \
        fi

RUN mkdir -p $LIQUIBASE_HOME
RUN curl -L https://github.com/liquibase/liquibase/releases/download/liquibase-parent-$LIQUIBASE_VERSION/liquibase-$LIQUIBASE_VERSION-bin.tar.gz > liquibase.tar.gz && \
    tar -xzf liquibase.tar.gz -C $LIQUIBASE_HOME/ && \
    rm liquibase.tar.gz

RUN curl -L https://jdbc.postgresql.org/download/$POSTGRES_JDBC_VERSION > $LIQUIBASE_HOME/lib/postgresql.jar

RUN curl -L https://github.com/USGS-CIDA/mlr-legacy-liquibase/archive/$MLR_LIQUIBASE_VERSION.zip > mlr-legacy-liquibase.zip && \
	unzip mlr-legacy-liquibase.zip -d $LIQUIBASE_HOME/ && \
	rm mlr-legacy-liquibase.zip
RUN mv $LIQUIBASE_HOME/mlr-legacy-liquibase-$MLR_LIQUIBASE_VERSION $LIQUIBASE_HOME/mlr-legacy-liquibase


############################################
# Grab Files to Configure Database with Liquibase
############################################

COPY ./testData $LIQUIBASE_HOME/mlr-legacy-liquibase/mlr-liquibase/mlr_legacy/testData

COPY ./dbInit/1_run_liquibase.sh /docker-entrypoint-initdb.d/

COPY ./dbInit/z.sh /docker-entrypoint-initdb.d/

RUN chmod -R 777 $LIQUIBASE_HOME

HEALTHCHECK --interval=2s --timeout=3s \
 CMD PGPASSWORD="${POSTGRES_PASSWORD}" | \
 	echo "SELECT 1+1;" | \
psql -U "postgres" -w > /dev/null || exit 1
