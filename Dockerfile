FROM mdillon/postgis:9.6-alpine

LABEL David Steinich <drsteini@usgs.gov>

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
	curl \openjdk8 \git \openssh && \
	rm -rf /var/lib/apt/lists/* 

############################################
# Install Liquibase
############################################

ENV LIQUIBASE_HOME /opt/liquibase
ENV LOCALONLY "-c listen_addresses='127.0.0.1, ::1'"
ENV LIQUIBASE_VERSION 3.5.3
ENV POSTGRES_JDBC_VERSION postgresql-42.2.4.jar
ENV MLR_LIQUIBASE_VERSION 1.1

RUN mkdir -p $LIQUIBASE_HOME
RUN curl -Lk https://github.com/liquibase/liquibase/releases/download/liquibase-parent-$LIQUIBASE_VERSION/liquibase-$LIQUIBASE_VERSION-bin.tar.gz > liquibase.tar.gz && \
    tar -xzf liquibase.tar.gz -C $LIQUIBASE_HOME/ && \
    rm liquibase.tar.gz

RUN curl -Lk https://jdbc.postgresql.org/download/$POSTGRES_JDBC_VERSION > $LIQUIBASE_HOME/lib/postgresql.jar

RUN curl -Lk https://github.com/USGS-CIDA/mlr-legacy-liquibase/archive/v$MLR_LIQUIBASE_VERSION.tar.gz > mlr-legacy-liquibase.tar.gz && \
	tar -xzf mlr-legacy-liquibase.tar.gz -C $LIQUIBASE_HOME/ && \
	rm mlr-legacy-liquibase.tar.gz 
RUN mv $LIQUIBASE_HOME/mlr-legacy-liquibase-$MLR_LIQUIBASE_VERSION $LIQUIBASE_HOME/mlr-legacy-liquibase


############################################
# Grab Files to Configure Database with Liquibase
############################################

COPY ./testData $LIQUIBASE_HOME/mlr-legacy-liquibase/mlr-liquibase/mlrLegacy/testData

RUN chmod -R 777 $LIQUIBASE_HOME

COPY ./dbInit/1_run_liquibase.sh /docker-entrypoint-initdb.d/

HEALTHCHECK --interval=2s --timeout=3s \
 CMD PGPASSWORD="${POSTGRES_PASSWORD}" | \
 	echo "SELECT 1+1;" | \
psql -U "postgres" -w > /dev/null || exit 1
