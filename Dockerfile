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
    && apk update && apk upgrade \
    && apk add --no-cache bash \
    && apk add --no-cache curl\
    && apk add --no-cache openjdk8 \
    && [ "$JAVA_HOME" = "$(docker-java-home)" ]


############################################
# Install Liquibase
############################################

ENV LIQUIBASE_HOME /opt/liquibase
ENV LOCALONLY "-c listen_addresses='127.0.0.1, ::1'"
ENV LIQUIBASE_VERSION 3.5.3
ENV POSTGRES_JDBC_VERSION 42.1.3

RUN mkdir -p $LIQUIBASE_HOME
RUN curl -Lk https://github.com/liquibase/liquibase/releases/download/liquibase-parent-$LIQUIBASE_VERSION/liquibase-$LIQUIBASE_VERSION-bin.tar.gz > liquibase-3.5.3-bin.tar.gz
RUN tar -xzf liquibase-$LIQUIBASE_VERSION-bin.tar.gz -C $LIQUIBASE_HOME/

ADD https://jdbc.postgresql.org/download/postgresql-42.1.3.jar $LIQUIBASE_HOME/lib/


############################################
# Grab Files to Configure Database with Liquibase
############################################

COPY ./dbInit/1_run_liquibase.sh /docker-entrypoint-initdb.d/

COPY ./dbInit/postgres.properties $LIQUIBASE_HOME/

COPY ./dbInit/databaseCreate.properties $LIQUIBASE_HOME/

COPY ./dbInit/liquibase.properties $LIQUIBASE_HOME/

COPY ./mlr-liquibase $LIQUIBASE_HOME/mlr-liquibase/

RUN chmod -R 777 $LIQUIBASE_HOME
