# Before building this image oracle/database:18.4.0-xe must be available at your private registry
# See https://github.com/marcelo-ochoa/docker-images/blob/master/OracleDatabase/README.md for more details
# Finally build using ./buildDockerImage.sh script
ARG ORACLE_VERSION
ARG ORACLE_RU
ARG ORACLE_IMAGE
FROM  "${ORACLE_IMAGE}:${ORACLE_VERSION}.${ORACLE_RU}" AS RDBMS_Release

FROM alpine/git:latest AS PCSource
LABEL maintainer="Marcelo Ochoa <mochoa@scotas.com>"
ARG REPO_URL
ENV REPO_URL ${REPO_URL:-https://github.com/scotas/pc.git}
ARG BRANCH
ENV BRANCH ${BRANCH}
ARG RELEASE
ENV RELEASE ${RELEASE}

WORKDIR /src

# Clone GitHub Repo from an specific branch
RUN git clone -b $BRANCH $REPO_URL

FROM  oraclelinux:8-slim
LABEL maintainer="Marcelo Ochoa <mochoa@scotas.com>"
ARG ORACLE_VERSION
ARG ORACLE_PDB
ENV ORACLE_PDB ${ORACLE_PDB}
ARG SRC_HOME
ENV SRC_HOME ${SRC_HOME}

USER root
RUN microdnf install oracle-instantclient-release-el8 zip unzip libnsl libaio && \
    rpm -Uvh https://packages.microsoft.com/config/centos/8/packages-microsoft-prod.rpm && \
    dnf config-manager --add-repo=https://download.docker.com/linux/centos/docker-ce.repo && \
    microdnf install --enablerepo ol8_appstream --enablerepo ol8_addons --enablerepo ol8_codeready_builder \
        oracle-instantclient-basic oracle-instantclient-devel oracle-instantclient-sqlplus \
        ant ant-contrib ant-junit apache-ivy git aspnetcore-runtime-3.1 docker-ce --nobest && \
    groupadd -g 54321 oinstall && useradd -g oinstall -u 54321 -N -G docker -m oracle && \
    echo 'export ORACLE_HOME=$(dirname $(dirname `readlink -f /usr/bin/sqlplus`))' >> /home/oracle/.bashrc && \
    echo 'export LD_LIBRARY_PATH=$ORACLE_HOME/lib' >> /home/oracle/.bashrc && \
    echo 'export PATH=$ORACLE_HOME/bin:$PATH' >> /home/oracle/.bashrc && \
    echo 'export JAVA_HOME=$(dirname $(dirname `readlink -f /etc/alternatives/java`))' >> /home/oracle/.bashrc && \
    rm -rf /var/tmp/* && \
    microdnf clean all

# Source of Scotas PC
COPY --from=PCSource --chown=oracle:oinstall /src/pc/ /home/pc/

# Required bin
COPY --from=RDBMS_Release --chown=oracle:oinstall "${SRC_HOME}/bin/wrap"  /home/oracle/
COPY --from=RDBMS_Release --chown=oracle:oinstall "${SRC_HOME}/lib/libclntsh.so.${ORACLE_VERSION}.1"  /home/oracle/
COPY --from=RDBMS_Release --chown=oracle:oinstall "${SRC_HOME}/lib/libclntshcore.so.${ORACLE_VERSION}.1"  /home/oracle/
COPY --from=RDBMS_Release --chown=oracle:oinstall "${SRC_HOME}/lib/libmql1.so"  /home/oracle/
COPY --from=RDBMS_Release --chown=oracle:oinstall "${SRC_HOME}/lib/libipc1.so"  /home/oracle/
COPY --from=RDBMS_Release --chown=oracle:oinstall "${SRC_HOME}/lib/libnnz${ORACLE_VERSION}.so"  /home/oracle/
COPY --from=RDBMS_Release --chown=oracle:oinstall "${SRC_HOME}/lib/libons.so"  /home/oracle/

RUN export ORACLE_HOME=$(dirname $(dirname `readlink -f /usr/bin/sqlplus`)) && \
    mkdir -p $ORACLE_HOME/network/admin/ && \
    mkdir -p $ORACLE_HOME/jdbc/lib/ && \
    ln -s $ORACLE_HOME/lib/ojdbc8.jar $ORACLE_HOME/jdbc/lib/ojdbc8.jar && \
    mv /home/oracle/wrap $ORACLE_HOME/bin && \
    mv /home/oracle/libclntsh.so.${ORACLE_VERSION}.1 $ORACLE_HOME/lib && \
    mv /home/oracle/libclntshcore.so.${ORACLE_VERSION}.1 $ORACLE_HOME/lib && \
    mv /home/oracle/libmql1.so $ORACLE_HOME/lib && \
    mv /home/oracle/libipc1.so $ORACLE_HOME/lib && \
    mv /home/oracle/libnnz${ORACLE_VERSION}.so $ORACLE_HOME/lib && \
    mv /home/oracle/libons.so $ORACLE_HOME/lib && \
    echo "${ORACLE_PDB}= \
(DESCRIPTION = \
  (ADDRESS = (PROTOCOL = TCP)(HOST = db)(PORT = 1521)) \
  (CONNECT_DATA = \
    (SERVER = DEDICATED) \
    (SERVICE_NAME = ${ORACLE_PDB}) \
  ) \
)" >> $ORACLE_HOME/network/admin/tnsnames.ora

WORKDIR	/home/pc
USER	oracle

# Define default command to start Oracle Database. 
CMD	exec /bin/bash
