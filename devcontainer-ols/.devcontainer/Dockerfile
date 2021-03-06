# Before building this image oracle/database:18.4.0-xe must be available at your private registry
# See https://github.com/marcelo-ochoa/docker-images/blob/master/OracleDatabase/README.md for more details
# Finally build using ./buildDockerImage.sh script
FROM alpine:latest AS Solr40Source
LABEL maintainer="Marcelo Ochoa <mochoa@scotas.com>"

RUN apk add --update subversion curl && rm -rf /var/cache/apk/*

WORKDIR /src
RUN	svn co http://svn.apache.org/repos/asf/lucene/dev/branches/lucene_solr_4_0
ADD	ols-solr-lucene.patch /src/lucene_solr_4_0/
WORKDIR /src/lucene_solr_4_0
RUN	svn patch /src/lucene_solr_4_0/ols-solr-lucene.patch

FROM alpine/git:latest AS OLSSource
LABEL maintainer="Marcelo Ochoa <mochoa@scotas.com>"
ARG REPO_URL
ENV REPO_URL ${REPO_URL:-https://github.com/scotas/ols.git}
ARG BRANCH
ENV BRANCH ${BRANCH:-v2.0.5}

WORKDIR /src

# Clone GitHub Repo from an specific branch
RUN git clone -b $BRANCH $REPO_URL

FROM	oracle/database:18.4.0-xe
LABEL maintainer="Marcelo Ochoa <mochoa@scotas.com>"
ARG BRANCH
ENV BRANCH ${BRANCH:-v2.0.5}
ARG DOCKER_GID
ENV DOCKER_GID ${DOCKER_GID:-999}

USER	root
RUN	rpm -Uvh https://packages.microsoft.com/config/centos/8/packages-microsoft-prod.rpm && \
	yum -y --enablerepo ol7_optional_latest --enablerepo ol7_addons install ant ant-contrib ant-junit apache-ivy git docker-engine aspnetcore-runtime-3.1 && \
	rm -rf /var/tmp/* && \
	yum clean all

ADD	https://github.com/scotas/ols/releases/download/$BRANCH/ODCI.jar /home/oracle/
ADD	https://github.com/scotas/ols/releases/download/$BRANCH/converter.jar /home/oracle/
ADD	https://github.com/scotas/ols/releases/download/$BRANCH/initsoxx.sql /home/oracle/
ADD	https://github.com/scotas/ols/releases/download/$BRANCH/translator.jar /home/oracle/
ADD	https://github.com/scotas/ols/releases/download/$BRANCH/sqljutl.sql /home/oracle/
ADD	https://github.com/scotas/ols/releases/download/$BRANCH/valid.ols /home/oracle/

# Source of Apache Solr/Lucene
COPY --from=Solr40Source --chown=oracle:oinstall /src/lucene_solr_4_0/ /home/oracle/lucene_solr_4_0/

# Source of Scotas PC
COPY --from=OLSSource --chown=oracle:oinstall /src/ols/ /home/ols/

RUN	usermod -G ${DOCKER_GID} oracle && \
	curl -L https://github.com/AdoptOpenJDK/openjdk11-binaries/releases/download/jdk-11.0.9.1+1/OpenJDK11U-jdk_x64_linux_hotspot_11.0.9.1_1.tar.gz | tar xfz - -C /usr/lib/jvm && \
	mv $ORACLE_HOME/rdbms/jlib/ODCI.jar $ORACLE_HOME/rdbms/jlib/ODCI.jar.bak && \
	mv /home/oracle/ODCI.jar $ORACLE_HOME/rdbms/jlib/ODCI.jar && \
	mv /home/oracle/converter.jar $ORACLE_HOME/rdbms/jlib/converter.jar && \
	mv $ORACLE_HOME/rdbms/admin/initsoxx.sql $ORACLE_HOME/rdbms/admin/initsoxx.sql.bak && \
	mv /home/oracle/initsoxx.sql $ORACLE_HOME/rdbms/admin/initsoxx.sql && \
	chmod a+r $ORACLE_HOME/rdbms/jlib/ODCI.jar && \
	chown oracle:oinstall $ORACLE_HOME/rdbms/jlib/ODCI.jar && \
	chmod a+r $ORACLE_HOME/rdbms/jlib/converter.jar && \
	chown oracle:oinstall $ORACLE_HOME/rdbms/jlib/converter.jar && \
	chmod a+r $ORACLE_HOME/rdbms/admin/initsoxx.sql && \
	chown oracle:oinstall $ORACLE_HOME/rdbms/admin/initsoxx.sql && \
	ln -s $ORACLE_HOME/jdbc/lib/ojdbc8.jar $ORACLE_HOME/jdbc/lib/ojdbc6.jar && \
	mv  /home/oracle/translator.jar /home/oracle/sqljutl.sql $ORACLE_HOME/rdbms/jlib && \
	chmod a+r $ORACLE_HOME/rdbms/jlib/translator.jar && \
	chmod a+r $ORACLE_HOME/rdbms/jlib/sqljutl.sql && \
	chown -R oracle:oinstall $ORACLE_HOME/rdbms/jlib/translator.jar && \
	chown -R oracle:oinstall $ORACLE_HOME/rdbms/jlib/sqljutl.sql && \
	ln -s /home/oracle/lucene_solr_4_0/solr /home/solr && \
	ln -s /home/oracle/lucene_solr_4_0/lucene /home/lucene && \
	chown -R oracle:oinstall /home/oracle && \
        echo "XEPDB1= \
(DESCRIPTION = \
  (ADDRESS = (PROTOCOL = TCP)(HOST = db)(PORT = 1521)) \
  (CONNECT_DATA = \
    (SERVER = DEDICATED) \
    (SERVICE_NAME = XEPDB1) \
  ) \
)" >> $ORACLE_HOME/network/admin/tnsnames.ora


ENV	JAVA_HOME=$ORACLE_HOME/jdk LD_LIBRARY_PATH=$ORACLE_HOME/lib

WORKDIR	/home
USER	oracle

# Define default command to start Oracle Database. 
CMD	exec /bin/bash

